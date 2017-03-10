//
//  NSArray+JSONExtender.h
//  MediaFireSDK
//
//  Created by Mike Jablonski on 4/15/15.
//  Copyright (c) 2015 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JSONExtender)

/**
 @brief Converts self into a JSON string representation of the array.
 */
- (NSString*)serializeJSON;

/**
 @brief Converts self into a JSON string representation of the array, with
 whitespace added for readability.
 */
- (NSString*)descriptionJSON;

@end
