//
//  DeviceAPI.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 4/4/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFDeviceAPI.h"
#import "MFConfig.h"
#import "NSDictionary+MapObject.h"
#import "MFHTTPOptions.h"

@implementation MFDeviceAPI

//------------------------------------------------------------------------------
- (id)init {
    self = [self initWithVersion:[MFConfig defaultAPIVersionForModule:@"MFDeviceAPI"]];
    if (self == nil) {
        return nil;
    }
    return self;
}

//------------------------------------------------------------------------------
- (id)initWithVersion:(NSString*)version {
    self = [super initWithPath:@"device" version:version];
    if (self == nil) {
        return nil;
    }
    return self;
}


//------------------------------------------------------------------------------
- (void)getChanges:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self getChanges:@{} query:parameters callbacks:cb];
}

- (void)getChanges:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL:@"get_changes.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)getForeignResources:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self getForeignResources:@{} query:parameters callbacks:cb];
}

- (void)getForeignResources:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL:@"get_foreign_resources.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)getPatch:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self getPatch:@{} query:parameters callbacks:cb];
}

- (void)getPatch:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL:@"get_patch.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)getResourceShares:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self getResourceShares:@{} query:parameters callbacks:cb];
}

- (void)getResourceShares:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL:@"get_resource_shares.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)getStatus:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self getStatus:@{} query:parameters callbacks:cb];
}

- (void)getStatus:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL:@"get_status.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)getTrash:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self getTrash:@{} query:parameters callbacks:cb];
}

- (void)getTrash:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL:@"get_trash.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)getUpdates:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self getUpdates:@{} query:parameters callbacks:cb];
}

- (void)getUpdates:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL:@"get_updates.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)getUserShares:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self getUserShares:@{} query:parameters callbacks:cb];
}

- (void)getUserShares:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL:@"get_user_shares.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)shareResources:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self shareResources:@{} query:parameters callbacks:cb];
}

- (void)shareResources:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL:@"share_resources.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)unshareResources:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self unshareResources:@{} query:parameters callbacks:cb];
}

- (void)unshareResources:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL:@"unshare_resources.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)followResource:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self followResource:@{} query:parameters callbacks:cb];
}

- (void)followResource:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL:@"follow_resource.php"}] query:parameters callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)unfollowResource:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self unfollowResource:@{} query:parameters callbacks:cb];
}

- (void)unfollowResource:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)cb {
    [self createRequest:[options merge:@{HURL:@"unfollow_resource.php"}] query:parameters callbacks:cb];
}



@end
