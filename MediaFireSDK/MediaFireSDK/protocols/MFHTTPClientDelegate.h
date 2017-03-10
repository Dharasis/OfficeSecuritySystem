//
//  MFHTTPClientDelegate.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/2/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^OperationBlock)(id response, NSInteger status, NSDictionary * downloaded);

@class MFURLRequestConfig;

@protocol MFHTTPClientDelegate <NSObject>

- (void)requestNotFound:(NSString*)description;
- (void)addRequest:(MFURLRequestConfig*)config;
- (void)destroy;

@end
