//
//  MFREST.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 2/17/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFREST.h"
#import "MFErrorMessage.h"
#import "MFErrorLog.h"
#import "MFConfig.h"

static NSString* HOST           = @"mediafire.com";
static NSString* SUBDOMAIN      = @"www";

@implementation MFREST

+ (NSString*)host {
    return [self host:true];
}

+ (NSString*)host:(BOOL)fullyQualified {
    if (!fullyQualified) {
        return SUBDOMAIN;
    }
    return [NSString stringWithFormat:@"%@.%@",SUBDOMAIN, HOST];
}

//------------------------------------------------------------------------------
+ (BOOL)success:(NSDictionary*)response {
    if ( response == nil ) {
        return NO;
    }
    NSString * result = [response[@"result"] capitalizedString];
    if (result != nil && [result isEqualToString:@"Error"]) {
        return false;
    }
    return true;
}

//------------------------------------------------------------------------------
+ (NSDictionary*)addResponseFormat:(NSDictionary*)params {
    if ( params == nil ) {
        return @{@"response_format":@"json"};
    }
    
    NSString* format = params[@"response_format"];
    // force null or "xml" format to "json"
    if ( format == nil || ! [format isEqualToString:@"json"] ) {
        NSMutableDictionary* newParams =
        [NSMutableDictionary dictionaryWithDictionary:params];
        newParams[@"response_format"] = @"json";
        params = (NSDictionary*)newParams;
    }
    
    return params;
}

//------------------------------------------------------------------------------
+ (NSDictionary*)processResponse:(NSString*)response mimetype:(NSString*)mime {
    // sanity check
    if ( response == nil || [response length] == 0 ) {
        return nil;
    }
    // we won't attempt to parse an xml response
    if ( mime != nil && [mime isEqualToString:@"application/xml"] ) {
        return [MFErrorMessage unexpectedResponse:response message:@"XML not supported at this time"];
    }
    
    NSError*        error       = nil;
    NSData*         jsonData    = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary*   responseObj = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    // Did response text parse correctly via JSON?
    if ( responseObj ) {
        responseObj = responseObj[@"response"];
        if ( responseObj == nil ) {
            // malformed response or unexpected JSON structure
            return [MFErrorMessage unexpectedResponse:response message:@"No response tag in JSON response"];
        } else {
            // Response passes sanity check
            return responseObj;
        }
    } else {
        // null response, maybe an aborted request or network timeout
        NSString * msg = [NSString stringWithFormat:@"JSON parse error %li: %@", (long)[error code], [error domain]];
        return [MFErrorMessage unexpectedResponse:response message:msg];
    }
}

@end
