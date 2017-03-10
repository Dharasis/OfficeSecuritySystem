//
//  MFHTTPData.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 6/2/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFHTTPData : NSObject

@property(strong,nonatomic)NSDictionary* callbacks;
@property(strong,nonatomic)NSURLSessionTask* task;
@property(strong,nonatomic)NSData* response;
@property(strong,nonatomic)NSURL* localPathForUpload;
@property(strong,nonatomic)NSURL* localPathForDownload;
@property(strong,nonatomic)NSDictionary* headers;
@property(strong,nonatomic)NSError* error;
@property NSInteger status;
@end
