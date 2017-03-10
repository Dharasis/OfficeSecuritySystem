//
//  MFHTTPData.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 6/2/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFHTTPData.h"

@implementation MFHTTPData

- (id)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    _callbacks = nil;
    _task = nil;
    _response = nil;
    _localPathForUpload = nil;
    _localPathForDownload = nil;
    _headers = nil;
    _error = nil;
    _status = 0;
    return self;
}

@end
