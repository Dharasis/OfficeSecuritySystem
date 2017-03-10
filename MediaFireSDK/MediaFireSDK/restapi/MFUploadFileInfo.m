//
//  MFUploadFileInfo.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 11/10/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFUploadFileInfo.h"

@implementation MFUploadFileInfo

- (id)init {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    _uploadData = nil;
    _fileName = nil;
    _fileHash = nil;
    _filePath = nil;
    _identifier = nil;
    _fileSize = 0;
    
    return self;
}
@end
