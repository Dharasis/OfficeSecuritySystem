//
//  MFFileAPI.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 2/25/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFFileAPI.h"
#import "MFConfig.h"
#import "NSDictionary+MapObject.h"
#import "MFHTTPOptions.h"

@implementation MFFileAPI

//------------------------------------------------------------------------------
- (id)init {
    self = [self initWithVersion:[MFConfig defaultAPIVersionForModule:@"MFFileAPI"]];
    if (self == nil) {
        return nil;
    }
    return self;
}

//------------------------------------------------------------------------------
- (id)initWithVersion:(NSString*)version {
    self = [super initWithPath:@"file" version:version];
    if (self == nil) {
        return nil;
    }
    return self;
}

//------------------------------------------------------------------------------
- (void)configureOneTimeDownload:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self configureOneTimeDownload:@{} query:parameters callbacks:callbacks];
}

- (void)configureOneTimeDownload:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"configure_one_time_download.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)copy:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self copy:@{} query:parameters callbacks:callbacks];
}

- (void)copy:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"copy.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)create:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self create:@{} query:parameters callbacks:callbacks];
}

- (void)create:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"create.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)createSnapshot:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createSnapshot:@{} query:parameters callbacks:callbacks];
}

- (void)createSnapshot:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"create_snapshot.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)delete:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self delete:@{} query:parameters callbacks:callbacks];
}

- (void)delete:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"delete.php"}]
                  query:parameters
             
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getFlags:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getFlags:@{} query:parameters callbacks:callbacks];
}

- (void)getFlags:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"get_flags.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getInfo:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getInfo:@{} query:parameters callbacks:callbacks];
}

- (void)getInfo:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"get_info.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getLinks:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getLinks:@{} query:parameters callbacks:callbacks];
}

- (void)getLinks:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"get_links.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getStatus:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getStatus:@{} query:parameters callbacks:callbacks];
}

- (void)getStatus:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"get_status.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getVersions:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getVersions:@{} query:parameters callbacks:callbacks];
}

- (void)getVersions:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"get_versions.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)move:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self move:@{} query:parameters callbacks:callbacks];
}

- (void)move:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"move.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)oneTimeDownload:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self oneTimeDownload:@{} query:parameters callbacks:callbacks];
}

- (void)oneTimeDownload:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"one_time_download.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)purge:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self purge:@{} query:parameters callbacks:callbacks];
}

- (void)purge:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"purge.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)recentlyModified:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self recentlyModified:@{} query:parameters callbacks:callbacks];
}

- (void)recentlyModified:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"recently_modified.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)restore:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self restore:@{} query:parameters callbacks:callbacks];
}

- (void)restore:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"restore.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)setFlags:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self setFlags:@{} query:parameters callbacks:callbacks];
}

- (void)setFlags:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"set_flags.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)update:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self update:@{} query:parameters callbacks:callbacks];
}

- (void)update:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"update.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)updateFile:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self updateFile:@{} query:parameters callbacks:callbacks];
}

- (void)updateFile:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"update_file.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)updatePassword:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self updatePassword:@{} query:parameters callbacks:callbacks];
}

- (void)updatePassword:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"update_password.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)zip:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self zip:@{} query:parameters callbacks:callbacks];
}

- (void)zip:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"zip.php"}]
                  query:parameters
              callbacks:callbacks];
}

@end
