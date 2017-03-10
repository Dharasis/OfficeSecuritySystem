//
//  MFMediaAPI.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/2/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 @brief The interface for requesting media.
 */
@interface MFMediaAPI : NSObject

/**
 @brief Returns a partial url formatted for conversion server requests.
 
 @param baseUrlString The absolute path to the server script.
 
 @param hash The hash of the file for the request.
 
 @param params Dictionary with options such as size_id and doc_type.
 */
+ (NSString*)generateConversionServerURL:(NSString*)baseUrlString withHash:(NSString*)hash withParameters:(NSDictionary*)params;

/**
 @brief Returns a url for document/image previews.
 
 @param parameters Dictionary with options such as size_id and doc_type
 
 @param hash The hash of the file to be requested.
 */
- (NSString*)getPreviewURL:(NSDictionary*)parameters withHash:(NSString*)hash;

/**
 @brief Downloads a preview, and returns the file binary up the callback chain. 
 Not recommended for use, unless you are only downloading small files and not 
 interested in caching them.
 
 @param parameters Dictionary with API parameter options.
 
 @param hash The hash of the file that the preview is being requested for.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getPreviewBinary:(NSDictionary*)parameters hash:(NSString*)hash callbacks:(NSDictionary*)callbacks;

/**
 @brief Downloads a preview, and returns the file binary up the callback chain.  
 Not recommended for use, unless you are only downloading small files and not 
 interested in caching them.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for 
 list of valid parameters.
 
 @param parameters Dictionary with API parameter options.
 
 @param hash The hash of the file that the preview is being requested for.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getPreviewBinary:(NSDictionary*)options query:(NSDictionary*)parameters hash:(NSString*)hash callbacks:(NSDictionary*)callbacks;

/**
 @brief Downloads a preview, saves it to the Caches folder, and returns the file 
 path to the downloaded file up the callback chain.

 @param parameters Dictionary with API parameter options.
 
 @param hash The hash of the file that the preview is being requested for.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getPreviewBinaryCachedPath:(NSDictionary*)parameters hash:(NSString*)hash callbacks:(NSDictionary*)callbacks;

/**
 @brief Downloads a preview, saves it to the Caches folder, and returns the file 
 path to the downloaded file up the callback chain.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for 
 list of valid parameters.
 
 @param parameters Dictionary with API parameter options.
 
 @param hash The hash of the file that the preview is being requested for.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)getPreviewBinaryCachedPath:(NSDictionary*)options query:(NSDictionary*)parameters hash:(NSString*)hash callbacks:(NSDictionary*)callbacks;

/**
 @brief Performs a direct download of a file at the given url.  Differs from 
 getPreviewBinaryCachedPath in that this method gets the original file, not a 
 preview.  The file is saved to a temporary folder and the path to the file is 
 passed up the callback chain.
 
 @param url The direct download url, which can be acquired via a call to 
 'getLinks'.  See MFFileAPI.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)directDownload:(NSURL*)url callbacks:(NSDictionary*)callbacks;

/**
 @brief Performs a direct download of a file at the given url.  Differs from 
 getPreviewBinaryCachedPath in that this method gets the original file, not a 
 preview.  The file is saved to a temporary folder and the path to the file is 
 passed up the callback chain.
 
 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for 
 list of valid parameters.
 
 @param url The direct download url, which can be acquired via a call to 
 'getLinks'.  See MFFileAPI.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)directDownload:(NSDictionary*)options url:(NSURL*)url callbacks:(NSDictionary*)callbacks;

/**
 @brief Performs a direct download of a file at the given url.  Differs from 
 getPreviewBinaryCachedPath in that this method gets the original file, not a 
 preview.  The file is saved to memory and passed up the callback chain.
 
 @param url The direct download url, which can be acquired via a call to 
 'getLinks'.  See MFFileAPI.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)directDownloadToMemory:(NSURL*)url callbacks:(NSDictionary*)callbacks;

/**
 @brief Performs a direct download of a file at the given url.  Differs from 
 getPreviewBinaryCachedPath in that this method gets the original file, not a 
 preview.  The file is saved to memory and passed up the callback chain.

 @param options Dictionary with HTTP client options. See MFHTTPOptions.h for 
 list of valid parameters.

 @param url The direct download url, which can be acquired via a call to 
 'getLinks'.  See MFFileAPI.
 
 @param callbacks A dictionary containing an onload callback and onerror
 callback. See NSDictionary(Callbacks).
 */
- (void)directDownloadToMemory:(NSDictionary*)options url:(NSURL*)url callbacks:(NSDictionary*)callbacks;

@end
