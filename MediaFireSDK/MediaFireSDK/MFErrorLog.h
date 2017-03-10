//
//  MFErrorLog.h
//  MediaFireSDK
//
//  Created by Ken Hartness on 10/2/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

#define mflog(...) [MFErrorLog in:__FILE__ at:__LINE__ message:__VA_ARGS__]

@interface MFErrorLog : NSObject

/** @name MFErrorLog Methods */

/**
 * Used by mflog(...) macro.
 *
 
 * @param srcfile The filename of the source code reporting the event.
 * @param line The line number of the source code reporting the event.
 * @param msg Descriptive words detailing the event.
 */
+ (void)in:(const char*)srcfile at:(NSUInteger)line message:(NSString*)msg, ...;

@end
