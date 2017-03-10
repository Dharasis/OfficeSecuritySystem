//
//  MFUserAPI.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 2/25/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFAPI.h"

/**
 @brief The interface for conducting user operations.
 */
@interface MFUserAPI : MFAPI

/**
 @brief Returns an MFUserAPI object initialized with a given API version number.
 
 @param version The version of the MediaFire API that the instance will default to.
 */
- (id)initWithVersion:(NSString*)version;

/**
 @brief Accepts the Terms of Service by sending the acceptance token.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#accept_tos)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)acceptTOS:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Accepts the Terms of Service by sending the acceptance token.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#accept_tos)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)acceptTOS:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Returns the HTML format of the MediaFire Terms of Service and its 
 revision number, date, whether the user has accepted it not not, and the 
 acceptance token (if the user has not accepted the latest terms).
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#fetch_tos)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)fetchTOS:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Returns the HTML format of the MediaFire Terms of Service and its
 revision number, date, whether the user has accepted it not not, and the
 acceptance token (if the user has not accepted the latest terms).
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#fetch_tos)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)fetchTOS:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Returns the URL of the operating user's avatar image.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_avater)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getAvatar:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Returns the URL of the operating user's avatar image.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_avater)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getAvatar:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Returns a list of the user's personal information.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_info)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getInfo:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Returns a list of the user's personal information.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_info)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getInfo:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Returns an array of limit-related statuses for the user.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_limits)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getLimits:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Returns an array of limit-related statuses for the user.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_limits)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getLimits:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Generates a 60-second Login Token to be used by the developer to log a 
 user directly into their account.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_login_token)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getLoginToken:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Generates a 60-second Login Token to be used by the developer to log a
 user directly into their account.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_login_token)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getLoginToken:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Generates a 10-minute access session token to be used in upcoming API 
 requests.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_session_token)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getSessionToken:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Generates a 10-minute access session token to be used in upcoming API
 requests.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_session_token)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getSessionToken:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Returns a list of the user's account settings.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_settings)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getSettings:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Returns a list of the user's account settings.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#get_settings)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getSettings:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Links a Facebook account with a MediaFire account.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#link_facebook)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)linkFacebook:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Links a Facebook account with a MediaFire account.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#link_facebook)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)linkFacebook:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Links a Twitter account with a MediaFire account.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#link_twitter)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)linkTwitter:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Links a Twitter account with a MediaFire account.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#link_twitter)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)linkTwitter:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Registers a MediaFire account.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#register)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)registerUser:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Registers a MediaFire account.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#register)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)registerUser:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Save a copy of an image file, or a remote image, to serve as the 
 operating user's avatar.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#set_avatar)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)setAvatar:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Save a copy of an image file, or a remote image, to serve as the
 operating user's avatar.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#set_avatar)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)setAvatar:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Set user preferences.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#set_settings)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)setSettings:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Set user preferences.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#set_settings)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)setSettings:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Unlinks the associated Facebook account from the session user's 
 MediaFire account.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#unlink_facebook)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)unlinkFacebook:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Unlinks the associated Facebook account from the session user's
 MediaFire account.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#unlink_facebook)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)unlinkFacebook:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Unlinks the associated Twitter account from the session user's MediaFire
 account.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#unlink_twitter)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)unlinkTwitter:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Unlinks the associated Twitter account from the session user's MediaFire
 account.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#unlink_twitter)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)unlinkTwitter:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Updates the user's personal information.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#update)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)update:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Updates the user's personal information.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/user.php#update)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)update:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

@end
