//
//  MFRequestHandler.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/7/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MFAPIURLRequestConfig;

/**
 @brief The most basic of the request managers.  Does not maintain any queues, does not track any tokens.  Provides the most basic functionality for MediaFire API requests that expect a JSON response.
 */
@interface MFRequestHandler : NSObject

/**
 @brief Dispatches a request immediately.
 
 @param config The configuration object of the request.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
+ (void)createRequest:(MFAPIURLRequestConfig*)config callbacks:(NSDictionary*)callbacks;

/**
 @brief Wraps a set of request callbacks to provide JSON parsing to the API response, and add some common error handlers.
 
 @param url The url of the original request.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
+ (NSDictionary*)getCallbacksForRequest:(NSURL*)url callbacks:(NSDictionary*)callbacks;

@end
