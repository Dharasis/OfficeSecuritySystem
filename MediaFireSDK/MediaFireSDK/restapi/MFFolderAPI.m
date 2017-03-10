//
//  MFFolderAPI.m
//  MediaFireSDK
//
//  Created by Mike Jablonski on 3/31/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFFolderAPI.h"
#import "NSDictionary+MapObject.h"
#import "MFConfig.h"
#import "MFHTTPOptions.h"

@implementation MFFolderAPI

//------------------------------------------------------------------------------
- (id)init {
    self = [self initWithVersion:[MFConfig defaultAPIVersionForModule:@"MFFolderAPI"]];
    if (self == nil) {
        return nil;
    }
    return self;
}

//------------------------------------------------------------------------------
- (id)initWithVersion:(NSString*)version {
    self = [super initWithPath:@"folder" version:version];
    if (self == nil) {
        return nil;
    }
    return self;
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
- (void)delete:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self delete:@{} query:parameters callbacks:callbacks];

}

- (void)delete:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"delete.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getContent:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getContent:@{} query:parameters callbacks:callbacks];

}
- (void)getContent:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"get_content.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getDepth:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getDepth:@{} query:parameters callbacks:callbacks];
}

- (void)getDepth:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"get_depth.php"}]
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
- (void)getRevision:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getRevision:@{} query:parameters callbacks:callbacks];
}

- (void)getRevision:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"get_revision.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getSiblings:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self getSiblings:@{} query:parameters callbacks:callbacks];
}

- (void)getSiblings:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"get_siblings.php"}]
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
- (void)purge:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self purge:@{} query:parameters callbacks:callbacks];
}

- (void)purge:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"purge.php"}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)search:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self search:@{} query:parameters callbacks:callbacks];
}

- (void)search:(NSDictionary*)options query:(NSDictionary*)parameters callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HURL:@"search.php"}]
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

@end
