//
//  MFSystemAPI.m
//  MediaFireSDK
//
//  Created by Mike Jablonski on 4/3/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFSystemAPI.h"
#import "NSDictionary+MapObject.h"
#import "MFConfig.h"
#import "MFHTTPOptions.h"

@implementation MFSystemAPI

//------------------------------------------------------------------------------
- (id)init {
    self = [self initWithVersion:[MFConfig defaultAPIVersionForModule:@"MFSystemAPI"]];
    if (self == nil) {
        return nil;
    }
    return self;
}

//------------------------------------------------------------------------------
- (id)initWithVersion:(NSString*)version {
    self = [super initWithPath:@"system" version:version];
    if (self == nil) {
        return nil;
    }
    return self;
}

//------------------------------------------------------------------------------
- (void)getEditableMedia:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getEditableMedia:@{} query:parameters callbacks:callbacks];
}

- (void)getEditableMedia:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL : @"get_editable_media.php", HTOKEN : HTKT_NONE}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getInfo:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getInfo:@{} query:parameters callbacks:callbacks];
}

- (void)getInfo:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL : @"get_info.php", HTOKEN : HTKT_NONE}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getLimits:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getLimits:@{} query:parameters callbacks:callbacks];
}

- (void)getLimits:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL : @"get_limits.php", HTOKEN : HTKT_NONE}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getMimeTypes:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getMimeTypes:@{} query:parameters callbacks:callbacks];
}

- (void)getMimeTypes:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL : @"get_mime_types.php", HTOKEN : HTKT_NONE}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getStatus:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getStatus:@{} query:parameters callbacks:callbacks];
}

- (void)getStatus:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL : @"get_status.php", HTOKEN : HTKT_NONE}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getSupportedMedia:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getSupportedMedia:@{} query:parameters callbacks:callbacks];
}

- (void)getSupportedMedia:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL : @"get_supported_media.php", HTOKEN : HTKT_NONE}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getVersion:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getVersion:@{} query:parameters callbacks:callbacks];
}

- (void)getVersion:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL : @"get_version.php", HTOKEN : HTKT_NONE}]
                  query:parameters
              callbacks:callbacks];
}

@end
