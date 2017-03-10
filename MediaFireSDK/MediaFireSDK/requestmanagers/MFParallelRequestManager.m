//
//  MFParallelRequestManager.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 3/3/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFParallelRequestManager.h"
#import "MFSerialRequestManagerDelegate.h"
#import "MFCircularQueue.h"
#import "NSDictionary+Callbacks.h"
#import "NSDictionary+MapObject.h"
#import "MFREST.h"
#import "MFHTTP.h"
#import "MFErrorLog.h"
#import "MFErrorMessage.h"
#import "MFConfig.h"
#import "MFAPIURLRequestConfig.h"
#import "MFRequestHandler.h"
#import "MFActionTokenAPI.h"

static NSString* DEFAULT_TYPE = @"image";
const char* MF_PARALLEL_REQUEST_DISPATCH_QUEUE = "com.mediafire.api.req.parallel";

@interface MFParallelRequestManager ()
@property(strong, nonatomic) MFCircularQueue* requests;
@property(strong, nonatomic) NSLock* requestLock;   // for accessing "requests"
@property(strong, nonatomic) NSLock* tokenLock;     // for accessing "token" "tokenFailure" and "waiting"
@property(strong, nonatomic) NSString* type;
@property(strong, nonatomic) NSString* token;
@property BOOL waiting;
@property BOOL tokenFailure;
@property(strong, nonatomic) NSString* tokenCallbacks;
@property(strong,nonatomic) dispatch_queue_t dispatchQueue;
@end

@implementation MFParallelRequestManager

@synthesize token = _token;
@synthesize actionAPI = _actionAPI;

//==============================================================================
// PUBLIC
//==============================================================================

//------------------------------------------------------------------------------
- (id)init {
    return [self initWithType:DEFAULT_TYPE];
}

//------------------------------------------------------------------------------
- (id)initWithType:(NSString*)type {

    if ([MFConfig instance] == nil) {
        return nil;
    }
    
    self = [super init];
    if ( self == nil ) {
        return nil;
    }
    
    _type = type;
    if (_type == nil || [_type isEqualToString:@""]) {
        _type = DEFAULT_TYPE;
    }
    _requests = [[MFCircularQueue alloc] init];
    _requestLock = [[NSLock alloc]init];
    _tokenLock = [[NSLock alloc]init];
    _token = @"";
    _waiting = false;
    _tokenFailure= false;
    _dispatchQueue = dispatch_queue_create(MF_PARALLEL_REQUEST_DISPATCH_QUEUE, DISPATCH_QUEUE_CONCURRENT);
    return self;
}

//------------------------------------------------------------------------------
- (void)createRequest:(MFAPIURLRequestConfig*)config callbacks:(NSDictionary*)callbacks {
    // don't allow any further requests to be attempted while we are purging.
    if ([self didFailToGetToken]) {
        callbacks.onerror(erm(noCurrentSession));
        return;
    }
    // sanity checks
    if ( callbacks == nil) {
        callbacks = [[NSDictionary alloc] init];
    }
    config.url = [config generateURL];
    if (config.url == nil) {
        callbacks.onerror(erm(nullField:@"url"));
        return;
    }
    config.queryDict = [MFREST addResponseFormat:config.queryDict];
    
    __weak MFParallelRequestManager* asyncSelf = self;
    
    NSDictionary * handleToken =
    @{ONERROR:^(NSDictionary* response) {
        // verify result is an error message
        if ( [MFErrorMessage isErrorMessage:response] ) {
            NSDictionary * err = [MFErrorMessage badResponse:response];
            if ( [MFErrorMessage code:err] == ERRCODE_INVALID_SESSION_TOKEN ) {
                // request failed because our action token expired.
                // re-queue the request and get a new token.
                config.httpFail = nil;
                config.httpSuccess = nil;
                config.httpProgress = nil;
                config.query = nil;
                [asyncSelf createRequest:config callbacks:callbacks];
                [asyncSelf askForNewToken];
                return;
            } else {
                // general API error.
                callbacks.onerror(response);
                return;
            }
        } else {
            // server error, network outage, or response was malformed.
            callbacks.onerror([MFErrorMessage badResponse:response]);
            return;
        }
    },
      ONLOAD: ^(NSDictionary* response) {
          // received an action token.
          if (response == nil || response[@"session_token"] == nil) {
              // the action token container was malformed.
              callbacks.onerror([MFErrorMessage nullField:@"session token"]);
              return;
          }
          config.queryDict = [config.queryDict merge:@{@"session_token" : response[@"session_token"]}];
          config.queryDict = [config.queryDict urlEncode];
          config.query = [config.queryDict mapToUrlString];
          NSDictionary* apiWrapperCallbacks = [asyncSelf getCallbacksForRequest:config callbacks:callbacks];
          config.httpSuccess = apiWrapperCallbacks[ONLOAD];
          config.httpFail = apiWrapperCallbacks[ONERROR];
          config.httpProgress = apiWrapperCallbacks[ONPROGRESS];
          [MFHTTP execute:config];
      }};
    // All requests must go in the queue for processing.
    [self queueRequest:config callbacks:handleToken];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"
//------------------------------------------------------------------------------
- (void)askForNewToken {
    __weak MFParallelRequestManager* asyncSelf = self;
    // success callback
    MFCallback newTokenAvailable = ^(NSDictionary* response) {
        [asyncSelf nextRequest];
    };
    
    // failure callback: if a request is queued, mark it as failed (to let GUI
    // know something is wrong and prevent requests hanging indefinitely)
    MFCallback failedToGetToken = ^(NSDictionary * response) {
        mflog(@"Failed to obtain session token: %@", response);
        [asyncSelf nextRequest];
    };
    
    // request another token
    [self getNewActionTokenFromCloudAPI:@{ONLOAD:newTokenAvailable,ONERROR:failedToGetToken}];
}
#pragma clang diagnostic pop

//------------------------------------------------------------------------------
- (void)endSession {
    // prevent any further requests from being processed.
    [self setFailure];
    // get rid of the existing token.
    [self setToken:nil];
    // remove pending requests from the queue.
    [self purgeRequests];
    // return the prm to a usable state.
    [self clearFailure];
}

//==============================================================================
// PRIVATE
//==============================================================================

//------------------------------------------------------------------------------
- (void)getNewActionTokenFromCloudAPI:(NSDictionary*)callbacks {
    // put all action requests of this type on hold until we get a new token.
    BOOL alreadyWaiting = [self waitForToken];
    if (alreadyWaiting) {
        return;
    }
    
    __weak MFParallelRequestManager* asyncSelf = self;
    NSDictionary* tokenCallbacks =
    @{ONLOAD: ^(NSDictionary* response) {
        asyncSelf.token = response[@"action_token"];
        [asyncSelf clearFailure];
        [asyncSelf stopWaitingForToken];
        callbacks.onload(@{});
    },
      ONERROR: ^(NSDictionary* response) {
          [asyncSelf setFailure];
          [asyncSelf stopWaitingForToken];
          callbacks.onerror(response);
      }};
    [self.actionAPI getActionToken:@{@"type" : self.type, @"lifespan" : @"240"} callbacks:tokenCallbacks];
}


//------------------------------------------------------------------------------
- (void)queueRequest:(MFAPIURLRequestConfig*)config callbacks:(NSDictionary*)callbacks {
    // sanity checks
    if (callbacks == nil) {
        return;
    }
    if (config == nil) {
        callbacks.onerror([MFErrorMessage nullField:@"config"]);
        return;
    }
    
    //  create a packet containing this method's parameters and save it for
    //  eventual processing when an action token is available.
    NSDictionary* request = @{@"config" : config, @"callbacks" : callbacks};
    
    [self addRequestToQueue:request];
    [self nextRequest];
}

//------------------------------------------------------------------------------
- (void)purgeRequests {
    NSDictionary* err = erm(obtainTokenFailure:@{});
    if ([self queueIsEmpty]) {
        // done purging, unlock this request manager.
        [self clearFailure];
        return;
    }
    NSDictionary* request = [self getNextRequestFromQueue];
    if (request != nil && request[@"callbacks"] != nil) {
        NSDictionary* callbacks = request[@"callbacks"];
        callbacks.onerror(err);
    }
    __weak MFParallelRequestManager* bself = self;
    dispatch_async(self.dispatchQueue, ^{
        [bself purgeRequests];
    });
}

//------------------------------------------------------------------------------
- (void)nextRequest {
    __weak MFParallelRequestManager* bself = self;
    dispatch_async(self.dispatchQueue, ^{
        if ([bself isWaitingOnNewToken]) {
            // A token request has already been made, just sit tight.
            return;
        }
        
        if ([bself didFailToGetToken]) {
            // Connection issue prevented getting a token, so lock this request
            // manager and error-out of all queued jobs.
            [bself purgeRequests];
            return;
        }
        
        if (![bself hasValidToken]) {
            // We've detected an invalid token, and we're not currently waiting
            // on a new one from the API.
            [bself askForNewToken];
            return;
        }
        
        NSString* token= self.token;
        
        if ([bself queueIsEmpty]) {
            // No requests to process at this time.
            return;
        }
        
        NSDictionary* request = [self getNextRequestFromQueue];
        // sanity check.  Shouldn't be nil anyway.
        if ( request == nil ) {
            return;
        }
        
        // attempt to resume the request
        [bself resumeRequest:request withToken:token];
    });
}

//------------------------------------------------------------------------------
- (void)resumeRequest:(NSDictionary*)request withToken:(NSString*)token {
    // Even though this is an "action token" the API requests don't care how
    // the token was acquired or what type it is, the API just expects a valid
    // "session_token" parameter.
    NSDictionary* callbacks = request[@"callbacks"];
    if ( callbacks == nil ) {
        erm(nullField:@"callbacks");
        return;
    }
    
    if ( token == nil ) {
        callbacks.onerror([MFErrorMessage badRequestFormat]);
    } else {
        callbacks.onload(@{@"session_token" : token});
    }
    
    [self nextRequest];
}

//------------------------------------------------------------------------------
- (NSDictionary*)getCallbacksForRequest:(MFAPIURLRequestConfig*)config callbacks:(NSDictionary*)callbacks {
    
    __weak MFParallelRequestManager* bself = self;
    
    NSDictionary* customizedCallbacks =
    @{ONLOAD:callbacks.onload,
      ONERROR:^(NSDictionary* response) {
        if ( [MFErrorMessage code:response] == ERRCODE_INVALID_SESSION_TOKEN ) {
            // request failed because our action token expired.
            // re-queue the request and get a new token.
            if ([config.queryDict[@"session_token"] isEqualToString:bself.token]) {
                [bself askForNewToken];
            }
        }
        // general API error.
        callbacks.onerror(response);
        return;
      }};
    
    return [MFRequestHandler getCallbacksForRequest:config.url callbacks:customizedCallbacks];
}


//==============================================================================
// THREAD-SAFE SETTERS/GETTERS
//==============================================================================

//------------------------------------------------------------------------------
- (NSString*)token {
    [self.tokenLock lock];
    NSString* token = _token;
    [self.tokenLock unlock];
    return token;
}

//------------------------------------------------------------------------------
- (void)setToken:(NSString*)token {
    [self.tokenLock lock];
    _token = token;
    [self.tokenLock unlock];
}

//------------------------------------------------------------------------------
- (BOOL)hasValidToken {
    NSString* token = self.token;
    if (token == nil || [token isEqualToString:@""]) {
        return false;
    }
    return true;
}

//------------------------------------------------------------------------------
- (BOOL)isWaitingOnNewToken {
    [self.tokenLock lock];
    bool waiting = self.waiting;
    [self.tokenLock unlock];
    return waiting;
}

//------------------------------------------------------------------------------
- (BOOL)waitForToken {
    BOOL alreadyWaiting = false;
    [self.tokenLock lock];
    if (self.waiting) {
        alreadyWaiting = true;
    } else {
        self.waiting = true;
    }
    [self.tokenLock unlock];
    return alreadyWaiting;
}

//------------------------------------------------------------------------------
- (void)stopWaitingForToken {
    [self.tokenLock lock];
    self.waiting = false;
    [self.tokenLock unlock];
}

//------------------------------------------------------------------------------
- (void)setFailure {
    [self.tokenLock lock];
    self.tokenFailure = true;
    [self.tokenLock unlock];
}

//------------------------------------------------------------------------------
- (void)clearFailure {
    [self.tokenLock lock];
    self.tokenFailure = false;
    [self.tokenLock unlock];
}

//------------------------------------------------------------------------------
- (BOOL)didFailToGetToken {
    [self.tokenLock lock];
    bool failure = self.tokenFailure;
    [self.tokenLock unlock];
    return failure;
}

//------------------------------------------------------------------------------
- (BOOL)queueIsEmpty {
    [self.requestLock lock];
    BOOL empty = [self.requests isEmpty];
    [self.requestLock unlock];
    return empty;
}

//------------------------------------------------------------------------------
- (NSDictionary*)getNextRequestFromQueue {
    NSDictionary* request = nil;
    [self.requestLock lock];
    request = [self.requests dequeueObject];
    [self.requestLock unlock];
    return request;
}

//------------------------------------------------------------------------------
- (void)addRequestToQueue:(NSDictionary*)request {
    [self.requestLock lock];
    [self.requests enqueue:request];
    [self.requestLock unlock];
}

//------------------------------------------------------------------------------
- (MFActionTokenAPI*)actionAPI {
    MFActionTokenAPI* api=nil;
    [self.tokenLock lock];
    if (_actionAPI == nil) {
        _actionAPI = [[MFActionTokenAPI alloc] init];
    }
    api = _actionAPI;
    [self.tokenLock unlock];
    return api;
}

//------------------------------------------------------------------------------
- (void)setActionAPI:(MFActionTokenAPI*)api {
    [self.tokenLock lock];
    _actionAPI = api;
    [self.tokenLock unlock];
}

@end
