//
//  NSDictionary+JSONExtender.h
//  MediaFireSDK
//
//  Created by Ken Hartness on 8/6/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONExtender)

/**
 @brief Converts self into a JSON string representation of the dictionary.
 */
- (NSString*) serializeJSON;

/**
 @brief Converts self into a JSON string representation of the dictionary, with 
 whitespace added for readability.
 */
- (NSString*) descriptionJSON;
@end
