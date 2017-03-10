//
//  NSData+BytesRange.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 11/18/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "NSData+BytesRange.h"

@implementation NSData (BytesRange)

- (NSData*)getBytesFromIndex:(unsigned long)index length:(unsigned long)length {
    if (index >= self.length) {
        return nil;
    }
    // truncate range if it's too long.
    if (index + length > self.length) {
        length = (unsigned long)(self.length - index);
    }

    unsigned char *plainText;
    plainText = malloc(length);
    if (!plainText) {
        return nil;
    }
    memset(plainText, 0, length);
    
    [self getBytes:plainText range:(NSRange){index, length}];
    
    NSData* unit = [NSData dataWithBytes:plainText length:length];
    free(plainText);
    return unit;
}

@end
