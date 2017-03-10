//
//  MFAPI.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 2/20/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFAPI.h"
#import "MFRequestManager.h"
#import "NSDictionary+Callbacks.h"
#import "MFErrorLog.h"
#import "MFErrorMessage.h"
#import "NSString+StringURL.h"
#import "MFHTTPOptions.h"
#import "MFAPIURLRequestConfig.h"
#import "MFRequestHandler.h"

@implementation MFAPI

//------------------------------------------------------------------------------
- (void)createRequest:(NSDictionary*)options query:(NSDictionary*)params callbacks:(NSDictionary*)cb {
    if (cb == nil) {
        erm(NullCallback);
        return;
    }
    if (options == nil) {
        cb.onerror([MFErrorMessage nullField:@"options"]);
        return;
    }
    
    MFAPIURLRequestConfig* config = [[MFAPIURLRequestConfig alloc] initWithOptions:options query:params];
    if (config == nil) {
        cb.onerror(erm(nullField:@"config"));
        return;
    }
    config.location = [self formatLocation:options[HURL]];

    
    [self setOverrides:config];

    [MFRequestManager createRequest:config callbacks:cb];
}


@end
