//
//  NSDictionary+Callbacks.m
//  MediaFireSDK
//
//  Created by Ken Hartness on 7/30/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import "NSDictionary+Callbacks.h"

const NSString* ONLOAD      = @"onload";
const NSString* ONERROR     = @"onerror";
const NSString* ONPROGRESS  = @"onprogress";
const NSString* ONUPDATE    = @"onupdate";

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"
static MFCallback ignoreblock = ^(NSDictionary* response) {
    return;
};

static MFProgressCallback progblock = ^(double progress) {
    return;
};
#pragma clang diagnostic pop

@implementation NSDictionary (Callbacks)
@dynamic onload;
@dynamic onerror;
@dynamic onprogress;
@dynamic onupdate;

//------------------------------------------------------------------------------
- (id)init {
    self = [super init];
    return self;
}

//------------------------------------------------------------------------------
- (MFCallback)onload {
    MFCallback loadcb = self[ONLOAD];
    if ( loadcb == nil ) {
        return [ignoreblock copy];
    } else {
        return loadcb;
    }
}

//------------------------------------------------------------------------------
- (MFCallback)onerror {
    MFCallback errorcb = self[ONERROR];
    if ( errorcb == nil ) {
        return [ignoreblock copy];
    } else {
        return errorcb;
    }
}

//------------------------------------------------------------------------------
- (MFCallback)onupdate {
    MFCallback updatecb = self[ONUPDATE];
    if ( updatecb == nil ) {
        return [ignoreblock copy];
    } else {
        return updatecb;
    }
}

//------------------------------------------------------------------------------
- (MFProgressCallback)onprogress {
    MFProgressCallback progcb = self[ONPROGRESS];
    if ( progcb == nil ) {
        return [progblock copy];
    } else {
        return progcb;
    }
}

@end
