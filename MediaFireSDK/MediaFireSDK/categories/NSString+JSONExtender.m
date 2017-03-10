//
//  NSString+JSONExtender.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 1/23/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "NSString+JSONExtender.h"

@implementation NSString (JSONExtender)

//------------------------------------------------------------------------------
- (NSDictionary*)deserializeJSON {
    NSError* err = nil;
    return [self deserializeJSON:&err];
}

//------------------------------------------------------------------------------
- (NSDictionary*)deserializeJSON:(NSError**)err {
    // sanity check
    if ([self isEqualToString:@""]) {
        return nil;
    }    
    // parse json to NSDictionary
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary* json =
    [[NSJSONSerialization JSONObjectWithData:data options:0 error:err] mutableCopy];
    
    return json;
}

@end
