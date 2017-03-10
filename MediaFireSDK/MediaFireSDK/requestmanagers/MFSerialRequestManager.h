//
//  MFSerialRequestManager.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/31/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFSerialRequestManagerDelegate.h"
@class MFSessionAPI;
@class MFAPIURLRequestConfig;

/**
 @brief The default request manager for MFAPIURLRequest objects.  Conforms to the MFSerialRequestManagerDelegate protocol.  Maintains a cache of 1 or more session tokens (serial tokens).  Also serves as the endpoint for logins.
 */
@interface MFSerialRequestManager : NSObject <MFSerialRequestManagerDelegate>

/**
 @brief An instance of the MFSessionAPI class.  Can be overidden to provide customized behaviors.
 */
@property(strong,nonatomic) MFSessionAPI* sessionAPI;

/**
 @brief Terminates session, clearing session tokens, and attempts to abort any active
 network connections. Actively executing API calls may complete successfully or terminate with an
 error; an error category of ERRCAT_NET may simply refer to the interruption
 of the connection caused by endSession. API call requests waiting for an
 available session token will receive an error with code ERRCODE_SESSION_CLOSED.
 */
+ (void)endSession;

/**
 @brief Returns true if 1 or more tokens is available.
 */
+ (BOOL)hasSession;

/**
 @brief Establishes a session with the MediaFire API via given credentials.  Should only be called once for an inactive session, once the first session token has been acquired, the SRM will automatically retrieve additional tokens up to the value in MFConfig.maxTokens.
 
 @param credentials A dictionary containing a credentials set.  See MFCredentials.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
*/
+ (void)login:(NSDictionary *)credentials callbacks:(NSDictionary *)callbacks;

/**
 @brief Frees a session token up for use.  
 
 @param token The string hash of the token.
 
 @param response The MediaFire API response.
 */
+ (void)releaseToken:(NSString*)token forResponse:(NSDictionary*) response;

/**
 @brief Adds a wrapped request to the queue.
 
 @param config The configruation object for the request.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)addRequest:(MFAPIURLRequestConfig*)config callbacks:(NSDictionary*)callbacks;

/**
 @brief Prepares a request and puts it into the queue.
 
 @param config The configruation object for the request.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
+ (void)createRequest:(MFAPIURLRequestConfig*)config callbacks:(NSDictionary *)callbacks;

/**
 @brief Purges a session token from the pool.
 */
+ (void)abandonToken:(NSString*)token;

@end
