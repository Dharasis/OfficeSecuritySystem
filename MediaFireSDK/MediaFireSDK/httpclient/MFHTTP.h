//
//  MFHTTP.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 11/1/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ReferenceCallback) (NSURLSessionTask* connection);
// Success and Failure callbacks use this prototype
typedef void (^OperationBlock)(id response, NSInteger status, NSDictionary * downloaded);
// Progress Callback prototype
typedef void (^ProgressBlock)(double progress);

typedef void (^HTTPCompletionHandler)(NSData* data, NSURLResponse* response, NSError* error);

@class MFURLRequestConfig;

/**
 @brief The endpoint for all http requests in the MediaFireSDK.
 */

@interface MFHTTP : NSObject

/**
 @brief A single-call function for any http request. Can be used to perform http requests against any server, not just the MFAPI.  Success and Error callbacks are triggered by http status code, but no parsing is done to the response text, that is left to the supplied callbacks.  Since this is a generic http client, it makes no assumptions about hostname or protocol, so urls must be fully qualified.  Relies on the default http client provided by MFconfig.defaultHttpClient.  If a custom client id is specified in the request, that client will be attempted first, and will fall back on the default client if the requested client does not exist.
 
 @param config A request config object, which must contain a fully qualified url.
 
 */
+ (void)execute:(MFURLRequestConfig*)config;

@end
