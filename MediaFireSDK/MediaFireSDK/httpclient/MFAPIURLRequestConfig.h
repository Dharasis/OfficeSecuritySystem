//
//  MFAPIURLRequestConfig.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/3/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFURLRequestConfig.h"


typedef NS_ENUM(NSUInteger, RequestTokenType) {
    MFTOKEN_SERIAL = 0,
    MFTOKEN_NONE = 1,
    MFTOKEN_PARALLEL_UPLOAD = 2,
    MFTOKEN_PARALLEL_IMAGE = 3
};


/**
 @brief The request config for MFAPI subclass requests.  These requests rely on the request managers to fully construct the url, and provide the url/post parameters as a dictionary that can be augmented and later converted to a query string.  See MFURLRequestConfig for more properties.
 */
@interface MFAPIURLRequestConfig : MFURLRequestConfig

/**
 @brief The type of token management associated with this request.  Defaults to MFTOKEN_SERIAL.  Other options are MFTOKEN_NONE, for API requests that do not require an active session token (anything in /api/system for example), MFTOKEN_PARALLEL_UPLOAD for uploads, and MFTOKEN_PARALLEL_IMAGE for image/document thumbnails.
 */
@property RequestTokenType tokenType;

/**
 @brief A dictionary containing the parameters for the request.
 */
@property(strong,nonatomic)NSDictionary* queryDict;

/**
 @brief The base url of the request (/api/1.0/folder/get_info.php).
 */
@property(strong,nonatomic)NSString* location;

/**
 @brief The host to be used for the request.  Leave this nil unless you need to explicitly override the API host name.
 */
@property(strong,nonatomic)NSString* host;

/**
 @brief Returns an MFAPIURLRequestConfig object initialized with a given set of options and parameters.
 
 @param options A dictionary of HTTP client options.  See MFHTTPOptions for a list of valid keys.
 
 @param params A dictionary of the request parameters.
 */
- (id)initWithOptions:(NSDictionary*)options query:(NSDictionary*)params;

/**
 @brief Returns a fully qualified url based on the configuration.
 */
- (NSURL*)generateURL;

@end
