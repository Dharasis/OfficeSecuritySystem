//
//  NSDictionary+Callbacks.h
//  MediaFireSDK
//
//  Created by Ken Hartness on 7/30/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MFCallback)(NSDictionary* response);
typedef void (^MFProgressCallback)(double progress);

/** @brief The dictionary key for a success callback. */
extern const NSString* ONLOAD;
/** @brief The dictionary key for an error callback. */
extern const NSString* ONERROR;
/** @brief The dictionary key for a progress callback. */
extern const NSString* ONPROGRESS;
/** @brief The dictionary key for an upate callback.  */
extern const NSString* ONUPDATE;

/**
 @brief The standard container for callbacks used throughout the MediaFire SDK.  Nearly all asynchronous functions in the SDK will expect an object of this type for callbacks.  You should always provide at least ONLOAD and ONERROR.  For upload requests, you should also provide ONUPDATE.
 */
@interface NSDictionary (Callbacks)

/**
 @brief A success callback.
 */
@property (nonatomic, readonly) MFCallback onload;

/**
 @brief An error callback.
 */
@property (nonatomic, readonly) MFCallback onerror;

/**
 @brief A progress callback.  Intended for rapid calls, for file transfer 
 progress indication.
 */
@property (nonatomic, readonly) MFProgressCallback onprogress;

/**
 @brief An update callback.  Similar to onprogress but uses the MFCallback
 style, not intended for rapid calls.  Used as an alternative to NSNotification.
 */
@property (nonatomic, readonly) MFCallback onupdate;
@end
