//
//  MFContactAPI.m
//  MediaFireSDK
//
//  Created by Mike Jablonski on 3/19/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFContactAPI.h"
#import "NSDictionary+MapObject.h"
#import "MFConfig.h"
#import "MFHTTPOptions.h"

@implementation MFContactAPI

//------------------------------------------------------------------------------
- (id)init {
    self = [self initWithVersion:[MFConfig defaultAPIVersionForModule:@"MFContactAPI"]];
    if (self == nil) {
        return nil;
    }
    return self;
}

//------------------------------------------------------------------------------
- (id)initWithVersion:(NSString*)version {
    self = [super initWithPath:@"contact" version:version];
    if (self == nil) {
        return nil;
    }
    return self;
}


//------------------------------------------------------------------------------
- (void)add:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self add:@{} query:parameters callbacks:cb];
}

- (void)add:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL : @"add.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)delete:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self delete:@{} query:parameters callbacks:cb];
}

- (void)delete:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL : @"delete.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)fetch:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self fetch:@{} query:parameters callbacks:cb];
}

- (void)fetch:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL : @"fetch.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)getAvatar:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self getAvatar:@{} query:parameters callbacks:cb];
}

- (void)getAvatar:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL : @"get_avatar.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)getSources:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self getSources:@{} query:parameters callbacks:cb];
}

- (void)getSources:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL : @"get_sources.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)setAvatar:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self setAvatar:@{} query:parameters callbacks:cb];
}

- (void)setAvatar:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL : @"set_avatar.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)summary:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self summary:@{} query:parameters callbacks:cb];
}

- (void)summary:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL : @"summary.php"}] query:parameters callbacks:cb];
}

@end
