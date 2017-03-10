//
//  MFActionTokenAPI.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/14/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFAPIBase.h"

/**
 @brief The interface for requesting action tokens.
 */
@interface MFActionTokenAPI : MFAPIBase

/**
 @brief Returns an MFActionTokenAPI object initialized with a given API version number.
 
 @param version The version of the MediaFire API that the instance will default to.
 */
- (id)initWithVersion:(NSString*)version;

/**
 @brief Requests an action token.
 
 @param parameters Dictionary with API parameter options. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_action_token)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getActionToken:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Requests an action token.

 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter options. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_action_token)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
*/
- (void)getActionToken:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

@end
