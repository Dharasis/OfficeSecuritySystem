//
//  MFNetworkIndicatorDelegate.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/7/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MFNetworkIndicatorDelegate <NSObject>

- (void)showNetworkIndicator;
- (void)hideNetworkIndicator;

@end
