//
//  MFRequestManager.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 2/19/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFRequestManager.h"
#import "NSDictionary+Callbacks.h"
#import "MFConfig.h"
#import "MFParallelRequestManagerDelegate.h"
#import "MFSerialRequestManagerDelegate.h"
#import "MFErrorMessage.h"
#import "MFAPIURLRequestConfig.h"
#import "MFRequestHandler.h"
#import "MFErrorLog.h"

@interface MFRequestManager()
@property(strong,nonatomic) NSArray* validParallelTypes;
@property(strong,nonatomic) NSMutableDictionary* parallelRequests;
@end

static MFRequestManager* instance = nil;

@implementation MFRequestManager

//------------------------------------------------------------------------------
- (id)init {
    if (instance != nil) {
        return nil;
    }
    if ([MFConfig instance] == nil){
        return nil;
    }
    self = [super init];
    if ( self == nil ) {
        return nil;
    }

    _validParallelTypes = @[@"image", @"upload"];
    _parallelRequests = [[NSMutableDictionary alloc] init];
    
    for (int i=0; i<_validParallelTypes.count ; i++) {
        NSString* type = _validParallelTypes[i];
        _parallelRequests[type] = [[[MFConfig parallelRequestDelegate] alloc] initWithType:type];
    }
    return self;
}

//------------------------------------------------------------------------------
+ (MFRequestManager*)instance {
    @synchronized(self) {
        if (instance == nil) {
            instance = [[MFRequestManager alloc] init];
        }
    }
    return instance;
}

//------------------------------------------------------------------------------
- (BOOL)isValidParallelType:(NSString*)type {
    if (type == nil || [type isEqualToString:@""]) {
        return false;
    }
    if ([self.validParallelTypes indexOfObject:type] == NSNotFound) {
        return false;
    }
    return true;
}

//------------------------------------------------------------------------------
+ (void)createRequest:(MFAPIURLRequestConfig*)config callbacks:(NSDictionary*)cb {
    [[MFRequestManager instance] createRequest:config callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)createRequest:(MFAPIURLRequestConfig*)config callbacks:(NSDictionary*)cb {
    // sanity check
    if (cb == nil) {
        mflog(@"Cannot create parallel request with nil callbacks.");
        return;
    }
    if (config == nil) {
        cb.onerror([MFErrorMessage nullField:@"config"]);
        return;
    }
    
    // If no request type has been specified, we default to serial mode, since
    // most of the APIs support it.
    // SERIAL REQUEST
    if (config.tokenType == MFTOKEN_SERIAL) {
        [[MFConfig serialRequestDelegate] createRequest:config callbacks:cb];
        return;
    }
    
    // PARALLEL REQUEST
    if (config.tokenType == MFTOKEN_PARALLEL_IMAGE) {
        id<MFParallelRequestManagerDelegate> pm = [self getParallelRequestManager:@"image"];
        if (pm == nil) {
            // validate pm is not nil
            cb.onerror([MFErrorMessage nullField:@"pm"]);
            return;
        }
        [pm createRequest:config callbacks:cb];
        return;
    }
    if (config.tokenType == MFTOKEN_PARALLEL_UPLOAD) {
        id<MFParallelRequestManagerDelegate> pm = [self getParallelRequestManager:@"upload"];
        if (pm == nil) {
            // validate pm is not nil
            cb.onerror([MFErrorMessage nullField:@"pm"]);
            return;
        }
        [pm createRequest:config callbacks:cb];
        return;
    }
    
    // NOTOKEN REQUEST
    if (config.tokenType == MFTOKEN_NONE) {
        [MFRequestHandler createRequest:config callbacks:cb];
        return;
    }
    
    // UNRECOGNIZED REQUEST TYPE
    cb.onerror([MFErrorMessage invalidField:@"api request type"]);
   
}

//------------------------------------------------------------------------------
- (id)getParallelRequestManager:(NSString*)type {
    return self.parallelRequests[type];
}

//------------------------------------------------------------------------------
+ (void)startSession:(NSString*)email withPassword:(NSString*)password andCallbacks:(NSDictionary*)callbacks {
    if ( email == nil || password == nil ) {
        if ( callbacks != nil ) {
            callbacks.onerror([MFErrorMessage noCredentials]);
        }
    } else {
        [[MFConfig credentialsDelegate] setMediaFire:email withPassword:password];
        [[MFConfig serialRequestDelegate] login:[[MFConfig credentialsDelegate] getCredentials] callbacks:callbacks];
    }
}

//------------------------------------------------------------------------------
+ (void)startSessionWithCallbacks:(NSDictionary*)callbacks {
    // Try to get credentials and login
    NSDictionary* credentials = [[MFConfig credentialsDelegate] getCredentials];
    if ( credentials == nil || ! [[MFConfig credentialsDelegate] isValid] ) {
        if ( callbacks != nil ) {
            callbacks.onerror([MFErrorMessage noCredentials]);
        }
    } else {
        [[MFConfig serialRequestDelegate] login:credentials callbacks:callbacks];
    }
}

//------------------------------------------------------------------------------
+ (void)startFacebookSession:(NSString*)authToken withCallbacks:(NSDictionary*)callbacks {
    if ( authToken == nil ) {
        if ( callbacks != nil ) {
            callbacks.onerror([MFErrorMessage noCredentials]);
        }
    } else {
        [[MFConfig credentialsDelegate] setFacebook:authToken];
        [[MFConfig serialRequestDelegate] login:[[MFConfig credentialsDelegate] getCredentials] callbacks:callbacks];
    }
}

//------------------------------------------------------------------------------
- (void)endSession {
    id<MFParallelRequestManagerDelegate> prm;
    NSString* prmName;
    for (int16_t i=0 ; i<self.validParallelTypes.count ; i++) {
        prmName = self.validParallelTypes[i];
        prm = self.parallelRequests[prmName];
        if (prm != nil && [prm respondsToSelector:@selector(endSession)]) {
            [prm endSession];
        }
    }
    [[MFConfig serialRequestDelegate] endSession];
}

//------------------------------------------------------------------------------
+ (void)endSession {
    [[MFRequestManager instance] endSession];
}

//------------------------------------------------------------------------------
+ (BOOL)hasSession {
    return [[MFConfig serialRequestDelegate] hasSession];
}

//------------------------------------------------------------------------------
+ (void)destroy {
    [[MFConfig serialRequestDelegate] destroy];
    @synchronized(self) {
        instance = nil;
    }
}


//------------------------------------------------------------------------------
+ (void)setSessionTokenAPI:(MFSessionAPI*)sessionAPI {
    id<MFSerialRequestManagerDelegate> srm = [[MFConfig serialRequestDelegate] getInstance];
    srm.sessionAPI = sessionAPI;
}

//------------------------------------------------------------------------------
+ (void)setActionTokenAPI:(MFActionTokenAPI*)tokenAPI forType:(NSString*)type {
    [[MFRequestManager instance] setActionTokenAPI:tokenAPI forType:type];
}

//------------------------------------------------------------------------------
- (void)setActionTokenAPI:(MFActionTokenAPI*)actionAPI forType:(NSString*)type{
    id<MFParallelRequestManagerDelegate> prm = self.parallelRequests[type];
    if ((prm != nil) && [prm conformsToProtocol:@protocol(MFParallelRequestManagerDelegate) ]) {
        prm.actionAPI = actionAPI;
    }
}

@end
