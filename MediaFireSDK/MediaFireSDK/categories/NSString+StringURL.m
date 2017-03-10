//
//  NSString+StringURL.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/31/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import "NSString+StringURL.h"

@implementation NSString (StringURL)

//------------------------------------------------------------------------------
- (NSString*) urlEncode {
    NSMutableCharacterSet * charSet = [[NSCharacterSet alphanumericCharacterSet] mutableCopy];
    [charSet addCharactersInString:@".-_~"];
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:charSet];
}

@end
