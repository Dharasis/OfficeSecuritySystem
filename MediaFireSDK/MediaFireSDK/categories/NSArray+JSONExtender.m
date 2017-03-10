//
//  NSArray+JSONExtender.m
//  MediaFireSDK
//
//  Created by Mike Jablonski on 4/15/15.
//  Copyright (c) 2015 MediaFire. All rights reserved.
//

#import "NSArray+JSONExtender.h"

@implementation NSArray (JSONExtender)

//------------------------------------------------------------------------------
- (NSString*)stringifyJSONpretty:(BOOL)pretty {
    NSError* err = nil;
    bool opt = (pretty ? NSJSONWritingPrettyPrinted : 0);
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self options:opt error:&err];
    
    if (err != nil) {
        return [NSString stringWithFormat:@"Error (%li) : %@", (long)[err code], [err domain]];
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

//------------------------------------------------------------------------------
- (NSString*)serializeJSON {
    return [self stringifyJSONpretty:FALSE];
}

//------------------------------------------------------------------------------
- (NSString*)descriptionJSON {
    return [self stringifyJSONpretty:TRUE];
}

@end
