//
//  MFActionTokenAPI.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/14/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFActionTokenAPI.h"
#import "MFAPIURLRequestConfig.h"
#import "MFConfig.h"
#import "MFSerialRequestManagerDelegate.h"

@implementation MFActionTokenAPI

//------------------------------------------------------------------------------
- (id)init {
    self = [self initWithVersion:[MFConfig defaultAPIVersionForModule:@"MFActionTokenAPI"]];
    if (self == nil) {
        return nil;
    }
    return self;
}

//------------------------------------------------------------------------------
- (id)initWithVersion:(NSString*)version {
    self = [super initWithPath:@"user" version:version];
    if (self == nil) {
        return nil;
    }
    return self;
}

//------------------------------------------------------------------------------
- (void)getActionToken:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getActionToken:@{} query:parameters callbacks:callbacks];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"
//------------------------------------------------------------------------------
- (void)getActionToken:(NSDictionary*)options query:(NSDictionary *)parameters callbacks:(NSDictionary *)callbacks {
    // put all action requests of this type on hold until we get a new token.
    MFAPIURLRequestConfig* config = [[MFAPIURLRequestConfig alloc]init];
    config.location = [self formatLocation:@"get_action_token.php"];
    config.method = @"POST";
    config.secure = true;
    config.queryDict = parameters;
    [self setOverrides:config];
    [[MFConfig serialRequestDelegate] createRequest:config callbacks:callbacks];
}
#pragma clang diagnostic pop

@end
