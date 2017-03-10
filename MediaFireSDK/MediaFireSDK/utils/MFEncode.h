//
//  MFEncode.h
//  MediaFireSDK
//
//  Created by Ken Hartness
//  Copyright 2013, MediaFire, LLC. All rights reserved.
//

/**
 @brief Supports the translation of binary data to strings and vice versa.
 */
@interface MFEncode : NSObject

/**
 -----------------------------
 #Converting Strings to Data#
 -----------------------------
 */

/**
 @brief Converts a hexadecimal string into an NSData object.
 
 @param string an NSString of hexadecimal values.  If the string contains non-
 hexadecimal values, they will be treated as zeros and appended to the end of
 the output, so 'FFDDPPBBAA' would effectively become 'FFDDBBAA00'.
 */
+ (NSData*)hexToData:(NSString*)string;

/**
 @brief Converts a base64 string into an NSData object.
 
 @param string an NSString of base64 values.
 */
+ (NSData*)base64ToData:(NSString*)string;

/**
 @brief Converts a UTF8 string into an NSData object.
 
 @param string a UTF8 NSString.
 */
+ (NSData*)stringToData:(NSString*)string;


/**
 ----------------------------
 #Converting Data to Strings#
 ----------------------------
 */

/**
 @brief Converts a data object into a hexadecimal string.
 
 @param data Accepts any NSObject but currently only supports NSData.  All other
 types will be ignored and the function will return nil.
 */
+ (NSString*)dataToHex:(id)data;

/**
 @brief Converts a data object into a base64 string.
 
 @param data Accepts any NSObject but currently only supports NSData.  All other
 types will be ignored and the function will return nil.
 */
+ (NSString*)dataToBase64:(id)data;

/**
 @brief Converts a data object into a UTF8 string.
 
 @param data Accepts any NSObject but currently only supports NSData.  All other
 types will be ignored and the function will return nil.
 */
+ (NSString*)dataToString:(id)data;
@end
