//
//  NSString+JSONExtender.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 1/23/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSONExtender)

/**
 @brief Converts self into an NSDictionary assuming self is a valid JSON string.
 */
- (NSDictionary*)deserializeJSON;

/**
 @brief Converts self into an NSDictionary assuming self is a valid JSON string.
 
 @param err An Error object to track failed JSON parsing attempts.
 */
- (NSDictionary*)deserializeJSON:(NSError**)err;

@end
