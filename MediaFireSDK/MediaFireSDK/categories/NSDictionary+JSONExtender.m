//
//  NSDictionary+JSONExtender.m
//  MediaFireSDK
//
//  Created by Ken Hartness on 8/6/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import "NSDictionary+JSONExtender.h"

@implementation NSDictionary (JSONExtender)

//------------------------------------------------------------------------------
- (NSString*)stringifyJSONpretty:(BOOL)pretty {
    NSError* err = nil;
    bool opt = (pretty?NSJSONWritingPrettyPrinted:0);
    
    NSData* jsonData =
    [NSJSONSerialization dataWithJSONObject:self options:opt error:&err];
    if ( err ) {
        return [NSString stringWithFormat:@"Error(%li): %@", (long)[err code], [err domain]];
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

//------------------------------------------------------------------------------
- (NSString*)serializeJSON {
    return [self stringifyJSONpretty:NO];
}

//------------------------------------------------------------------------------
- (NSString*)descriptionJSON {
    return [self stringifyJSONpretty:YES];
}
@end
