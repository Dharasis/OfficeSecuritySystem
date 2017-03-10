//
//  MFUploadAPI.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 2/25/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFAPI.h"

/**
 @brief The interface for conducting upload operations.
 */
@interface MFUploadAPI : MFAPI

/**
 @brief Returns an MFUploadAPI object initialized with a given API version number.
 
 @param version The version of the MediaFire API that the instance will default to.
 */
- (id)initWithVersion:(NSString*)version;


/**
 @brief Checks for existing file before upload.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/upload.php#check)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)check:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Checks for existing file before upload.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/upload.php#check)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)check:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;


/**
 @brief Performs an instant upload.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/upload.php#instant)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)instant:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Performs an instant upload.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/upload.php#instant)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)instant:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Performs a file upload.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/upload.php#resumable)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)uploadFile:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Performs a unit (resumable) upload.
 
 @param fileInfo Dictionary with file information for the upload, such as name, size, and hash.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/upload.php#resumable)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)uploadUnit:(NSDictionary*)fileInfo query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Performs a unit (resumable) upload.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.

 @param fileInfo Dictionary with file information for the upload, such as name, size, and hash.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/upload.php#resumable)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)uploadUnit:(NSDictionary*)options fileInfo:(NSDictionary*)fileInfo query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Performs an upload.  Not recommended for direct use.

 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/upload.php#resumable)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)upload:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Checks the status of an upload.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/upload.php#poll_upload)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)pollUpload:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

/**
 @brief Checks the status of an upload.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for list of valid parameters.
 
 @param parameters Dictionary with API parameter parameters. See
 [Developer Documentation](https://www.mediafire.com/developers/core_api/1.0/upload.php#poll_upload)
 for list of valid parameters.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)pollUpload:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks;

+ (int)getFirstEmptyBitFromWord:(int32_t)bitmap;

+ (int)getFirstEmptyBit:(NSDictionary*)bitmap;
@end
