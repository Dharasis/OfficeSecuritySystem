//
//  HTTPRequestOptions.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 1/28/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @brief The name of the "url" property in an options dictionary.
 */
extern NSString* const HURL;

/**
 @brief The name of the "timeout" property in an options dictionary.
 */
extern NSString* const HTIMEOUT;

/**
 @brief The name of the "method" property in an options dictionary.
 */
extern NSString* const HMETHOD;

/**
 @brief The name of the "request headers" property in an options dictionary.
 */
extern NSString* const HREQHEADERS;

/**
 @brief The name of the "url params" property in an options dictionary.
 */
extern NSString* const HURLPARAMS;

/**
 @brief The name of the "local path" property in an options dictionary.
 */
extern NSString* const HLOCALPATH;

/**
 @brief The name of the "upload type" property in an options dictionary.
 */
extern NSString* const HUPTYPE;

/**
 @brief The name of the "upload data" property in an options dictionary.  Should only have a value if HUPTYPE == HUPT_DATA.
 */
extern NSString* const HUPDATA;

/**
 @brief The name of the "upload path" property in an options dictionary.  Should only have a value if HUPTYPE == HUPT_PATH.
 */
extern NSString* const HUPPATH;

/**
 @brief The value of the "upload type" property when uploading a file by path.
 */
extern NSString* const HUPT_PATH;

/**
 @brief The value of the "upload type" property when uploading raw a NSData block.
 */
extern NSString* const HUPT_DATA;

/**
 @brief The name of the "host" property in an options dictionary.
 */
extern NSString* const HHOST;

/**
 @brief The name of the "token type" property in an options dictionary.
 */
extern NSString* const HTOKEN;

/**
 @brief The value of the "upload type" property when token type is parallel.
 */
extern NSString* const HTKT_PARA;

/**
 @brief The value of the "upload type" property when token type is none.
 */
extern NSString* const HTKT_NONE;

/**
 @brief The value of the "upload type" property when token type is serial.
 */
extern NSString* const HTKT_SERIAL;

/**
 @brief The name of the "parallel token type" property in an options dictionary.
 */
extern NSString* const HPARALLEL;

/**
 @brief The value of the "parallel token type" property when token type is image.
 */
extern NSString* const HPTT_IMAGE;

/**
 @brief The value of the "parallel token type" property when token type is upload.
 */
extern NSString* const HPTT_UPLOAD;

/**
 @brief The name of the "secure" property in an options dictionary.
 */
extern NSString* const HSECURE;

/**
 @brief The name of the "http client id" property in an options dictionary.
 */
extern NSString* const HCLIENT;

/**
 @brief The name of the "description" property in an options dictionary.
 */
extern NSString* const HDESCRIPTION;