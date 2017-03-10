//
//  MFHTTPClient.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 5/30/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFHTTPClientDelegate.h"

@class MFHTTPData;
@class MFURLRequestConfig;

typedef void (^OperationBlock)(id response, NSInteger status, NSDictionary * downloaded);

/**
 @brief Base class for NSURLSessionDelegate http client.  This is NOT the default http client used by MFHTTP.  Conforms to NSURLSessionDelegate, NSURLSessionTaskDelegate, and MFHTTPClientDelegate.  If you need to implement your own custom HTTP client, it is sufficient to conform to the MFHTTPClient protocol, but you can also subclass MFHTTPClient as all it's properties are public.  
 */

@interface MFHTTPClient : NSObject <NSURLSessionDelegate,NSURLSessionTaskDelegate,MFHTTPClientDelegate>

/**
 @brief The instance of the session that this client uses for all requests.
 */
@property(strong,nonatomic)NSURLSession* session;

/**
 @brief Temporary storage for all pending/active requests.
 */
@property(strong,nonatomic)NSMutableDictionary* appRequestData;

/**
 @brief Used to generate unique ids for tasks.
 */
@property int64_t counter;

/**
 @brief A lock.
 */
@property(strong,nonatomic)NSLock* opLock;

/**
 The default method for requests passing thru this client.  Can be @"GET" or @"POST".
 */
@property(strong,nonatomic)NSString* defaultMethod;

/**
 @brief returns an instance of the MFHTTPClient initialized with a given configuration.
 
 @param config The configuration for the http client.
 */
- (id)initWithConfig:(NSURLSessionConfiguration*)config;

/**
 @brief Adds a request to this client's queue.
 
 @param config The configuration object for the request.
 */
- (void)addRequest:(MFURLRequestConfig*)config;

/**
 @brief Returns a request bundle object from appRequestData identified by a unique name.
 
 @param task The task associated with the original request.
 */
- (MFHTTPData*)getAppRequestDataForTask:(NSURLSessionTask*)task;

/**
 @brief Returns a request bundle object from appRequestData identified by a unique name, and removes it from appRequestData.
 
 @param task The task associated with the original request.
 */
- (MFHTTPData*)removeAppRequestDataForTask:(NSURLSessionTask*)task;

/**
 @brief Returns an NSURLSessionTask object initialized with a given request and configuration.
 
 @param request A urlrequest set to the method and url of the original request.
 
 @param config The configuration object for the original request.
 */
- (id)constructTaskWithRequest:(NSMutableURLRequest*)request config:(MFURLRequestConfig*)config;

/**
 @brief Destroys this client.
 */
- (void)destroy;

@end
