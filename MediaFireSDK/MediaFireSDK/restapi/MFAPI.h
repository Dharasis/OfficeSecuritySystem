//
//  MFAPI.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 2/20/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MFAPIBase.h"

@interface MFAPI : MFAPIBase


- (void)createRequest:(NSDictionary*)options query:(NSDictionary*)params callbacks:(NSDictionary*)cb;

@end
