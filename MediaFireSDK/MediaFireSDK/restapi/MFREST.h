//
//  MFREST.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 2/17/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFREST : NSObject


// Core API
+ (NSString*)host;
+ (NSString*)host:(BOOL)fullyQualified;
+ (BOOL)success:(NSDictionary*)response;

/*
 Accepts a dictionary of url parameters, and ensures that the hash also
 contains a "response_format" field set to "json"
 
 @param params an input dictionary that might or might not already contain
 a value for @"response_format" */
+ (NSDictionary*)addResponseFormat:(NSDictionary*)params;

/* This does not implement XML processing at this time. */
+ (NSDictionary*)processResponse:(NSString*)response mimetype:(NSString*)mime;


@end
