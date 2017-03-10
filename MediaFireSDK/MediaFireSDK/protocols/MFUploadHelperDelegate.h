//
//  MFUploadHelperDelegate.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 11/6/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFUploadFileInfo.h"

typedef void (^MFUploadFilePrepCallback)(MFUploadFileInfo*, NSError*);

@protocol MFUploadHelperDelegate <NSObject>

- (NSData*)getChunk:(int)chunkNumber forFile:(NSDictionary*)fileInfo;

- (void)prepareFileForUpload:(NSDictionary*)fileInfo withCompletionHandler:(MFUploadFilePrepCallback)block;

@end
