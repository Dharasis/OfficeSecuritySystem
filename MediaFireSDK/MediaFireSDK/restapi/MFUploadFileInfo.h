//
//  MFUploadFileInfo.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 11/10/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFUploadFileInfo : NSObject

@property (nonatomic,strong) NSData* uploadData;
@property (nonatomic,strong) NSString* fileName;
@property (nonatomic,strong) NSString* fileHash;
@property (nonatomic,strong) NSString* filePath;
@property (nonatomic,strong) NSString* identifier;
@property (nonatomic,assign) int64_t fileSize;

@end
