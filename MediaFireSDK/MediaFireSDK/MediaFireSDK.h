//
//  MediaFireSDK.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 4/15/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFSessionAPI.h"
#import "MFActionTokenAPI.h"
#import "MFContactAPI.h"
#import "MFDeviceAPI.h"
#import "MFFileAPI.h"
#import "MFFolderAPI.h"
#import "MFSystemAPI.h"
#import "MFUploadAPI.h"
#import "MFUploadTransaction.h"
#import "MFUserAPI.h"
#import "MFMediaAPI.h"

/**
 @brief The main MediaFire API access object.  Must be initialized first by using createWithConfig:.  You must supply your own app id, and if necessary, your own api key.  Once initialized, a login attempt can be made with startSession:withPassword:andCallbacks: or startFacebookSession:withCallbacks.  If credentials have already been stored and validated, use startSession:withCallbacks.  If you don't need to override the default behaviors of the SDK, then almost everything you will need can be done thru the MediaFireSDK shared instance.
 */

@interface MediaFireSDK : NSObject

/**
 @brief Initializes the shared instance with given configuration.
 
 @param config Dictionary containing app-specific configuration.  Expects @"app_id" to be a non-nil NSString.  See MFConfig for a list of valid keys.
 */
+ (bool)createWithConfig:(NSDictionary*)config;

/**
 @brief Returns the MediaFireSDK shared instance.
 */
+ (instancetype)getInstance;

- (void)startSession:(NSString*)email withPassword:(NSString*)password andCallbacks:(NSDictionary*)callbacks;

/**
 @brief Establishes a session with the MediaFire API via email and password combination.
 
 @param email The user's email address.
 
 @param password The user's password.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
+ (void)startSession:(NSString*)email withPassword:(NSString*)password andCallbacks:(NSDictionary*)callbacks;

- (void)startSessionWithCallbacks:(NSDictionary*)callbacks;

/**
 @brief Establishes a session with the MediaFire API via stored credentials.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
+ (void)startSessionWithCallbacks:(NSDictionary*)callbacks;

- (void)startFacebookSession:(NSString*)authToken withCallbacks:(NSDictionary*)callbacks;

/**
 @brief Establishes a session with the MediaFire API via facebook token.
 
 @param authToken The user's Facebook token, supplied by Facebook after a successful authentication thru facebook.com.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
+ (void)startFacebookSession:(NSString*)authToken withCallbacks:(NSDictionary*)callbacks;

- (void)endSession;

/**
 @brief Purges all existing session tokens, disabling any further requests.
 */
+ (void)endSession;

/**
 @brief Returns true if 1 or more session tokens are available.
 */
+ (BOOL)hasSession;

- (void)destroy;

/**
 @brief Destroys the MediaFireSDK shared instance.
 */
+ (void)destroy;

- (MFSessionAPI*)SessionAPI;

/**
 @brief Returns the MediaFireSDK singleton's stored instance of the MFSessionAPI class.
 */
+ (MFSessionAPI*)SessionAPI;

- (MFActionTokenAPI*)ActionTokenAPI;

/**
 @brief Returns the MediaFireSDK singleton's stored instance of the MFActionTokenAPI class.
 */
+ (MFActionTokenAPI*)ActionTokenAPI;

- (MFContactAPI*)ContactAPI;

/**
 @brief Returns the MediaFireSDK singleton's stored instance of the MFConctactAPI class.
 */
+ (MFContactAPI*)ContactAPI;

- (MFDeviceAPI*)DeviceAPI;

/**
 @brief Returns the MediaFireSDK singleton's stored instance of the MFDeviceAPI class.
 */
+ (MFDeviceAPI*)DeviceAPI;

- (MFFileAPI*)FileAPI;

/**
 @brief Returns the MediaFireSDK singleton's stored instance of the MFFileAPI class.
 */
+ (MFFileAPI*)FileAPI;

- (MFFolderAPI*)FolderAPI;

/**
 @brief Returns the MediaFireSDK singleton's stored instance of the MFFolderAPI class.
 */
+ (MFFolderAPI*)FolderAPI;

- (MFSystemAPI*)SystemAPI;

/**
 @brief Returns the MediaFireSDK singleton's stored instance of the MFSystemAPI class.
 */
+ (MFSystemAPI*)SystemAPI;

- (MFUploadAPI*)UploadAPI;

/**
 @brief Returns the MediaFireSDK singleton's stored instance of the MFUploadAPI class.
 */
+ (MFUploadAPI*)UploadAPI;

- (MFUserAPI*)UserAPI;

/**
 @brief Returns the MediaFireSDK singleton's stored instance of the MFUserAPI class.
 */
+ (MFUserAPI*)UserAPI;

- (MFMediaAPI*)MediaAPI;

/**
 @brief Returns the MediaFireSDK singleton's stored instance of the MFMediaAPI class.
 */
+ (MFMediaAPI*)MediaAPI;



@end
