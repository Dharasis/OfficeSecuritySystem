//
//  MFEncode.m
//  MediaFireSDK
//
//  Created by Ken Hartness
//  Copyright 2013, MediaFire, LLC. All rights reserved.
//

#import "MFEncode.h"

@implementation MFEncode

//------------------------------------------------------------------------------
+ (id)alloc {
	return nil;
}

//------------------------------------------------------------------------------
+ (NSData*)hexToData:(NSString*)string {
	if (string == nil) {
        return nil;
    }

	NSUInteger size = [string length];
	size = size / 2 + size % 2;
	NSMutableData* data = [NSMutableData dataWithLength:size];
	unsigned char* byte = [data mutableBytes];
	for (int i = 0; i < [string length]; i += 2) {
		unsigned digit = [self hexdigit:[string characterAtIndex:i]];
		if (digit == 0x10) {
			--i;
			continue;
		}
		*byte = digit << 4;

		if (i < [string length] - 1) {
			digit = [self hexdigit:[string characterAtIndex:(i+1)]];
			if (digit != 0x10) {
                *byte |= digit;
            }
		}
		++byte;
	}
	return data;
}

//------------------------------------------------------------------------------
+ (NSData*)base64ToData:(NSString*)string {
	if (string == nil) {
        return nil;
    }
    
    return [[NSData alloc] initWithBase64EncodedString:string options:0];
}

//------------------------------------------------------------------------------
+ (NSData*)stringToData:(NSString*)string {
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

//------------------------------------------------------------------------------
+ (NSString*)dataToHex:(id)data {
    if (![data isKindOfClass:[NSData class]] || data == nil) {
		return nil;
	}

    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    
    if (!dataBuffer) {
        return nil;
    }
    
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i=0; i<dataLength; ++i) {
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    
    return [NSString stringWithString:hexString];
}

//------------------------------------------------------------------------------
+ (NSString*)dataToBase64:(id)data {
    if (![data isKindOfClass:[NSData class]] || data == nil) {
		return nil;
	}
    
    return [data base64EncodedStringWithOptions:0];
}

//------------------------------------------------------------------------------
+ (NSString*)dataToString:(id)data {
    if (![data isKindOfClass:[NSData class]] || data == nil) {
		return nil;
	}
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


//==============================================================================
// PRIVATE
//==============================================================================

//------------------------------------------------------------------------------
+ (unsigned)hexdigit:(unichar)ch {
	unsigned result = 0x10;
    
	if (ch >= '0' && ch <= '9') {
        result = ch - '0';
    } else if (ch >= 'A' && ch <= 'F') {
        result = ch - 'A' + 10;
	} else if (ch >= 'a' && ch <= 'f') {
        result = ch - 'a' + 10;
    }
    
	return result;
}

@end



