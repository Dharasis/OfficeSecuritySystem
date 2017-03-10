//
//  MFSerialRequestManagerDelegate.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 4/15/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MFAPIURLRequestConfig;
@class MFSessionAPI;

@protocol MFSerialRequestManagerDelegate<NSObject>
@property(strong,nonatomic)MFSessionAPI* sessionAPI;
+ (void)endSession;
+ (void)destroy;
+ (id)getInstance;
+ (void)login:(NSDictionary *)credentials callbacks:(NSDictionary *)callbacks;
+ (void)releaseToken:(NSString*)token forResponse:(NSDictionary*) response;
+ (void)createRequest:(MFAPIURLRequestConfig*)config callbacks:(NSDictionary *)callbacks;
+ (BOOL)hasSession;
+ (void)abandonToken:(NSString*)token;
@end
