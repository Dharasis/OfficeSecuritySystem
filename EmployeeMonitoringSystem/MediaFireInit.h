//
//  MediaFireInit.h
//  EmployeeMonitoringSystem
//
//  Created by Sumit Ghosh on 11/02/16.
//  Copyright © 2016 Globussoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaFireSDK.h"
#import "NSDictionary+Callbacks.h"
#import "MFFolderAPI.h"
#import "SingeltonClass.h"


@interface MediaFireInit : NSObject
-(void)mediaFireLogin;
-(void)fetching:(NSString*)path;
-(void)syncAllDatas:(NSString*)localDirectory;
@end
