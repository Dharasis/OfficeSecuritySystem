//
//  NSDictionary+MapObject.h
//  MediaFireSDK
//
//  Created by Ken Hartness on 8/23/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MapObject)
+ (id)dictionaryFromObject:(id) object withMap:(NSDictionary*)map;
- (BOOL)mapTo:(id)object withMap:(NSDictionary*)map;

/** 
 @brief Will return a dictionary whose keys are the values and values are the keys IF
 each key maps to a unique value.
 */
- (NSDictionary*)reverseLookup;

/** 
 @brief Creates a dictionary that is a combination of self and other.  
 
 @param other The dictionary to be merged with self.
 */
- (NSDictionary*)merge:(NSDictionary*)other;

/**
 @brief Converts the contents of the dictionary to a string of name=value&name=value...
 */
- (NSString*)mapToUrlString;

/**
 @brief Urlencodes the contents of the dictionary and returns the changes as a new,
 mutable dictionary.
 */
- (NSMutableDictionary*)urlEncode;
@end
