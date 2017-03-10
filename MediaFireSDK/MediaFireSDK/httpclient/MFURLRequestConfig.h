//
//  MFURLRequestConfig.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 6/3/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ReferenceCallback)(NSURLSessionTask* connection);
// Success and Failure callbacks use this prototype
typedef void (^OperationBlock)(id response, NSInteger status, NSDictionary * downloaded);
// Progress Callback prototype
typedef void (^ProgressBlock)(double progress);

/**
 @brief The HTTP URL request configuration object for all requests in the MediaFire SDK.
 */
@interface MFURLRequestConfig : NSObject

/** @brief A fully qualified url.  May or may not contain a query string. */
@property(strong,nonatomic)NSURL* url;
/** @brief The HTTP Method, supports GET and POST. */
@property(strong,nonatomic)NSString* method;
/** @brief Setting this to true will enable https on the request. */
@property BOOL secure;
/** @brief Dictionary for request headers. */
@property(strong,nonatomic)NSDictionary* headers;
/** @brief The query string.  In a GET request, it is appened to any pre-existing parameters in the url. */
@property(strong,nonatomic)NSString* query;
/** @brief In the case of a POST, this should contain the post body. */
@property(strong,nonatomic)NSData* body;
/** @brief For an upload transmitting directly from a local file, this field should contain the local file path. */
@property(strong,nonatomic)NSURL* localPathForUpload;
/** @brief For a download request, this field should be set as the final destination path of the file. */
@property(strong,nonatomic)NSURL* localPathForDownload;
/** @brief Unique identifier. */
@property(strong,nonatomic)NSString* desc;
/** @brief Name of an http client registered thru MFConfig. */
@property(strong,nonatomic)NSString* httpClientId;
/** @brief The http success callback. Fired when http status == 200.  */
@property(strong,nonatomic)OperationBlock httpSuccess;
/** @brief The http failure callback.  Fired when http status != 200. (Depending on your http client, this may not include redirects)*/
@property(strong,nonatomic)OperationBlock httpFail;
/** @brief The http progress callback. */
@property(strong,nonatomic)ProgressBlock httpProgress;
/** @brief The http task reference callback.  Implement this if you want to be able to abort the request. */
@property(strong,nonatomic)ReferenceCallback httpReference;
@end
