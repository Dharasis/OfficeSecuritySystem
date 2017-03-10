//
//  MFRequestHandler.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/7/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFRequestHandler.h"
#import "MFREST.h"
#import "NSDictionary+Callbacks.h"
#import "MFErrorMessage.h"
#import "MFAPIURLRequestConfig.h"
#import "MFHTTP.h"
#import "NSDictionary+MapObject.h"
#import "MFErrorLog.h"

static int LOG_TRUNCATE_AMOUNT = 256;

typedef void (^SMRestCallback)(id responseText, NSInteger status, NSDictionary* downloaded);

@implementation MFRequestHandler

//------------------------------------------------------------------------------
+ (void)createRequest:(MFAPIURLRequestConfig*)config callbacks:(NSDictionary*)callbacks {
    if ( callbacks == nil) {
        callbacks = [[NSDictionary alloc] init];
    }
    
    config.url = [config generateURL];
    if (config.url == nil) {
        callbacks.onerror(erm(nullField:@"url"));
        return;
    }
    config.queryDict = [MFREST addResponseFormat:config.queryDict];
    config.queryDict = [config.queryDict urlEncode];
    config.query = [config.queryDict mapToUrlString];
    
    NSDictionary* apiWrapperCallbacks = [MFRequestHandler getCallbacksForRequest:config.url callbacks:callbacks];
    config.httpSuccess = apiWrapperCallbacks[ONLOAD];
    config.httpFail = apiWrapperCallbacks[ONERROR];
    config.httpProgress = apiWrapperCallbacks[ONPROGRESS];
    config.httpReference = apiWrapperCallbacks[@"httpTask"];
    
    [MFHTTP execute:config];
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"
//------------------------------------------------------------------------------
+ (NSDictionary*)getCallbacksForRequest:(NSURL*)url callbacks:(NSDictionary*)callbacks {
    
    SMRestCallback successCallback = ^(id response, NSInteger status, NSDictionary * downloaded) {
        if ((downloaded != nil) && (downloaded[@"blob"] != nil) && (response == nil)) {
            callbacks.onload(downloaded);
        }
        NSString* responseString = [NSString stringWithFormat:@"request success : %@",response];
        if (responseString.length && (responseString.length > LOG_TRUNCATE_AMOUNT)) {
            int64_t size = responseString.length;
            responseString = [NSString stringWithFormat:@"%@... (truncated %lli)",[responseString substringToIndex:LOG_TRUNCATE_AMOUNT],(size-LOG_TRUNCATE_AMOUNT) ];
        }
        mflog(@"%@",responseString);
        NSDictionary* jsonResponse = nil;
        if ([response isKindOfClass:[NSString class]]) {
            jsonResponse = [MFREST processResponse:response mimetype:@"application/json"];
        } else if ([response isKindOfClass:[NSDictionary class]]) {
            jsonResponse = response;
        } else {
            if (response != nil) {
                jsonResponse = @{@"blob": response};
            }
        }
        // failed to parse
        if (jsonResponse == nil) {
            callbacks.onerror([MFErrorMessage noResponseTo:url]);
            return;
        }
        if ( [MFREST success:jsonResponse] ) {
            callbacks.onload(jsonResponse);
            return;
        }
        // Our response was a 200 but not an actual success
        NSDictionary* err = [MFErrorMessage badResponse:jsonResponse];
        callbacks.onerror(err);
    };
    
    SMRestCallback errorCallback = ^(id response, NSInteger status, NSDictionary* downloaded) {
        mflog(@"request error : %@",response);
        // Ignore non-strings in error response
        if (![response isKindOfClass:[NSString class]]) {
            response = @"";
        }
        NSDictionary* jsonResponse = [MFREST processResponse:response mimetype:@"application/json"];
        // sanity check on result
        if (jsonResponse == nil) {
            if (status == ERRCODE_FILECOPY) {
                callbacks.onerror(erm(fileCopyFailed));
            }
            callbacks.onerror(erm(badHTTP:status message:[url absoluteString]));
            return;
        }
        // look for erroneus success response
        if ([MFREST success:jsonResponse]) {
            callbacks.onerror(erm(unexpectedResponse:jsonResponse message:@"Success reported with error callback"));
            return;
        }
        // either the response is a standard error response or it isn't.
        if ([MFErrorMessage isErrorMessage:jsonResponse]) {
            callbacks.onerror(jsonResponse);
            return;
        }
        callbacks.onerror(erm(badResponse:jsonResponse));
    };
    
    NSMutableDictionary* cb =
    [[NSMutableDictionary alloc] initWithDictionary: @{ONLOAD:[successCallback copy], ONERROR:[errorCallback copy]}];
    
    // set up extra callbacks
    if (callbacks[ONPROGRESS] != nil) {
        cb[ONPROGRESS] = [callbacks[ONPROGRESS] copy];
    }
    if (callbacks[@"httpTask"] != nil) {
        cb[@"httpTask"] = [callbacks[@"httpTask"] copy];
    }
    
    return cb;
}
#pragma clang diagnostic pop

@end
