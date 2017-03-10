//
//  NSDictionary+MapObject.m
//  MediaFireSDK
//
//  Created by Ken Hartness on 8/23/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import "NSDictionary+MapObject.h"
#import "NSString+StringURL.h"

@implementation NSDictionary (MapObject)

//------------------------------------------------------------------------------
/* Map contents of dictionary whose keys are keys in map to properties of the
 * object. The property names are the values of the corresponding keys in the
 * map. For example, if a customer object has properties id, name, and balance,
 * then [@{@"CustomerId":@5897, @"CustomerName":@"Smith, John", @"Balance":@500}
 * mapTo:customer withMap:@{@"CustomerId":@"id", @"CustomerName":@"name",
 * @"Balance":@"balance"}] would set customer's id to 5897, name to
 * @"Smith, John", and balance to 500.0.
 * Because REST API responses may surround numeric data with quotes, causing
 * them to be treated as strings, a # prefix may be used to force string values
 * to be treated as numbers (e.g., @"Balance":@"#balance"}. The prefix is not
 * considered part of the property name.
 */
- (BOOL)mapTo:(id)object withMap:(NSDictionary*)map {
    BOOL mappedSomething = NO;
    
    if ( object == nil || map == nil ) {
        return NO;
    }
    
    for (NSString* key in map) {
        id value = [self objectForKey:key];
        if ( value == nil ) {
            continue;
        }
        NSString* property = [map objectForKey:key];
        if ( (property != nil) && (property.length > 0) && [property characterAtIndex:0] == '#' ) {
            // If supposed to be a number, try to convert it to one.
            property = [property substringFromIndex:1];
            if ( [value isKindOfClass:[NSString class]] ) {
                if ( [value length] == 0 || isdigit([value characterAtIndex:0]) ) {
                    if ( [value length] > 9 ) {
                        value = [NSNumber numberWithLongLong:[value longLongValue]];
                    } else {
                        value = [NSNumber numberWithInteger:[value integerValue]];
                    }
                } else {
                    continue; // not a number so leave it null
                }
            }
        }
        [object setValue:value forKey:property];

        mappedSomething = YES;
    }
    
    return mappedSomething;
}

//------------------------------------------------------------------------------
/* Opposite of mapTo:withMap:, dictionaryFromObject:withMap: creates a
 * dictionary from the properties of an object. For example, given a dictionary
 * response, the following will produce data equal to response, at least in
 * those fields included in the mapping:
 * id object = ...;
 * if ( [response mapTo:object withMap:map] ) {
 *     NSDictionary* data = [NSDictionary dictionaryFromObject:object
 *                                                     withMap:[map reverseLookup]];
 */
+ (id)dictionaryFromObject:(id) object withMap:(NSDictionary*)map {
    if ( object == nil || map == nil || [map count] == 0 ) {
        return nil;
    }

    NSMutableArray* keys = [[NSMutableArray alloc] initWithCapacity:[map count]];
    NSMutableArray* values = [[NSMutableArray alloc] initWithCapacity:[map count]];
    
    for ( NSString* propertyKey in map ) {
        NSString* property = propertyKey;
        NSString* key = [map objectForKey:propertyKey];
        id value = nil;
    
        if ( key == nil ) {
            continue;
        }

        if ( propertyKey.length > 0 && [propertyKey characterAtIndex:0] == '#' ) {
            property = [propertyKey substringFromIndex:1];
        }
        
        value = [object valueForKey:property];
        if ( value == nil ) {
            continue;
        }
        [keys addObject:key];
        [values addObject:value];
    }

    if ( [keys count] > 0 ) {
        return [NSDictionary dictionaryWithObjects:values forKeys:keys];
    } else {
        return nil;
    }
}

//------------------------------------------------------------------------------
- (NSDictionary*)reverseLookup {
    NSMutableDictionary* result = [[NSMutableDictionary alloc]
                                   initWithCapacity:[self count]];
    for ( NSString* key in self ) {
        id value = [self objectForKey:key];
        if ( [result objectForKey:value] == nil ) {
            [result setObject:key forKey:value];
        } else {
            result = nil;
            break;
        }
    }
    
    return result;
}

//------------------------------------------------------------------------------
-(NSDictionary*)merge:(NSDictionary*)other {
    NSMutableDictionary* newDictionary =
    [NSMutableDictionary dictionaryWithDictionary:self];

    [newDictionary addEntriesFromDictionary:other];
    return newDictionary;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"
//------------------------------------------------------------------------------
- (NSString*)mapToUrlString {
    __block NSString* newUrl = nil;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        if ( newUrl == nil ) {
            newUrl = [[NSString alloc] initWithFormat:@"%@=%@", key, obj];
        } else {
            newUrl = [newUrl stringByAppendingFormat:@"&%@=%@", key, obj];
        }
    }];
    return newUrl;
}

//------------------------------------------------------------------------------
- (NSDictionary*)urlEncode {
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        if ( [obj isKindOfClass:[NSString class]] ) {
            params[key] = [obj urlEncode];
        } else {
            params[key] = obj;
        }
    }];
    return params;
}
#pragma clang diagnostic pop

@end
