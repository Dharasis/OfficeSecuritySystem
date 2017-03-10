//
//  MFHash.h
//  MediaFireSDK
//
//  Created by Ken Hartness
//  Copyright 2013, MediaFire, LLC. All rights reserved.
//
#import <Foundation/Foundation.h>

/**
 @brief Convenience functions for invoking hash algorithms.
 */

typedef NSData* (^MFHashChunkBlock)(int index, BOOL* done);

@interface MFHash : NSObject

/**
 -----------------------------
 #Hashing to Data#
 -----------------------------
 */

/**
 @brief Creates a data blob representing the sha1 hash of the provided object.
 
 @param data Accepts NSData and NSString.  Any other types will result in a nil
 return value.
 */
+ (NSData*)sha1:(id)data;

/**
 @brief Creates a data blob representing the sha1 hash of an item that is fed 
 in chunks to the algorithm by the supplied callback.  Should be used for any
 items that are larger than 10 megs.
 
 @param block An MFHashChunkBlock, which returns an NSData object representing
 the chunk of the item to be hashed.
 */
+ (NSData*)sha1Chunked:(MFHashChunkBlock)block;

/**
 @brief Creates a data blob representing the sha256 hash of the provided object.
 
 @param data Accepts NSData and NSString.  Any other types will result in a nil
 return value.
 */
+ (NSData*)sha256:(id)data;

/**
 @brief Creates a data blob representing the sha256 hash of an item that is fed
 in chunks to the algorithm by the supplied callback.  Should be used for any
 items that are larger than 10 megs.
 
 @param block An MFHashChunkBlock, which returns an NSData object representing
 the chunk of the item to be hashed.
 */
+ (NSData*)sha256Chunked:(MFHashChunkBlock)block;

/**
 @brief Creates a data blob representing the md5 hash of the provided object.
 
 @param data Accepts NSData and NSString.  Any other types will result in a nil
 return value.
 */
+ (NSData*)md5:(id)data;

/**
 @brief Creates a data blob representing the md5 hash of an item that is fed
 in chunks to the algorithm by the supplied callback.  Should be used for any
 items that are larger than 10 megs.
 
 @param block An MFHashChunkBlock, which returns an NSData object representing
 the chunk of the item to be hashed.
 */
+ (NSData*)md5Chunked:(MFHashChunkBlock)block;


/**
 -----------------------------
 #Hashing to a String#
 -----------------------------
 */

/**
 @brief Creates a string representation of the sha1 hash of the provided object.
 
 @param data Accepts NSData and NSString.  Any other types will result in a nil
 return value.
 */
+ (NSString*)sha1Hex:(id)data;

/**
 @brief Creates a string representation of the sha1 hash of an item that is fed
 in chunks to the algorithm by the supplied callback.  Should be used for any
 items that are larger than 10 megs.
 
 @param block An MFHashChunkBlock, which returns an NSData object representing
 the chunk of the item to be hashed.
 */
+ (NSString*)sha1HexChunked:(MFHashChunkBlock)block;

+ (NSString*)sha1HashFileAtPath:(NSString*)path blockSize:(unsigned long long)size;

/**
 @brief Creates a string representation of the sha256 hash of the provided object.
 
 @param data Accepts NSData and NSString.  Any other types will result in a nil
 return value.
 */
+ (NSString*)sha256Hex:(id)data;

/**
 @brief Creates a string representation of the sha256 hash of an item that is fed
 in chunks to the algorithm by the supplied callback.  Should be used for any
 items that are larger than 10 megs.
 
 @param block An MFHashChunkBlock, which returns an NSData object representing
 the chunk of the item to be hashed.
 */
+ (NSString*)sha256HexChunked:(MFHashChunkBlock)block;

+ (NSString*)sha256HashFileAtPath:(NSString*)path blockSize:(unsigned long long)size;

/**
 @brief Creates a string representation of the md5 hash of the provided object.
 
 @param data Accepts NSData and NSString.  Any other types will result in a nil
 return value.
 */
+ (NSString*)md5Hex:(id)data;

/**
 @brief Creates a string representation of the md5 hash of an item that is fed
 in chunks to the algorithm by the supplied callback.  Should be used for any
 items that are larger than 10 megs.
 
 @param block An MFHashChunkBlock, which returns an NSData object representing
 the chunk of the item to be hashed.
 */
+ (NSString*)md5HexChunked:(MFHashChunkBlock)block;

+ (NSString*)md5HashFileAtPath:(NSString*)path blockSize:(unsigned long long)size;
@end
