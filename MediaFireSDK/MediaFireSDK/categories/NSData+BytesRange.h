//
//  NSData+BytesRange.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 11/18/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (BytesRange)

- (NSData*)getBytesFromIndex:(unsigned long)index length:(unsigned long)length;

@end
