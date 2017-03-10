//
//  MFRequestManager.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 2/19/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MFAPIURLRequestConfig;
@class MFActionTokenAPI;
@class MFSessionAPI;

/**
 @brief The central dispatcher for all MFAPIURLRequest objects.  Requests created by MFAPI subclasses  will almost always go thru the MFRequestManager.  This is a singleton class that routes API requests to the appropriate manager.
 */

@interface MFRequestManager : NSObject

/**
 @brief Returns the MFRequestManager shared instance.
 */
+ (MFRequestManager*)instance;

/**
 @brief Dispatches a request to an appropriate manager.
 
 @param options The configuration object of the request.
 
 @param cb A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
+ (void)createRequest:(MFAPIURLRequestConfig*)options callbacks:(NSDictionary*)cb;

/**
 @brief Establishes a session with the MediaFire API via email and password combination.
 
 @param email The user's email address.
 
 @param password The user's password.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
+ (void)startSession:(NSString*)email withPassword:(NSString*)password andCallbacks:(NSDictionary*)callbacks;

/**
 @brief Establishes a session with the MediaFire API via stored credentials.

 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
*/
+ (void)startSessionWithCallbacks:(NSDictionary*)callbacks;

/**
 @brief Establishes a session with the MediaFire API via facebook token.
 
 @param authToken The user's Facebook token, supplied by Facebook after a successful authentication thru facebook.com.

 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
*/
+ (void)startFacebookSession:(NSString*)authToken withCallbacks:(NSDictionary*)callbacks;

/**
 @brief Purges all existing session tokens, disabling any further requests.
 */
+ (void)endSession;

/**
 @brief Returns true if 1 or more session tokens are available.
 */
+ (BOOL)hasSession;

/**
 @brief Destroys the MFRequestManager shared instance.
 */
+ (void)destroy;

/**
 @brief Overrides the MFSessionAPI instance used by the Serial Request Manager Delegate with a given instance.
 
 @param sessionAPI A customized instance of the MFSessionAPI class.
 */
+ (void)setSessionTokenAPI:(MFSessionAPI*)sessionAPI;

/**
 @brief Overrides the MFActionTokenAPI instance used by the Parallel Request Manager for a specific type with a given instance.
 
 @param actionAPI A customized instance of the MFActionTokenAPI class.
 
 @param type A string identifier for the Parallel Request Manager to modify.  Can be set to @"upload" or @"image".
 */
+ (void)setActionTokenAPI:(MFActionTokenAPI*)actionAPI forType:(NSString*)type;

@end