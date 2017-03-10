//
//  ActivityControl.h
//  EmployeeMonitoringSystem
//
//  Created by Sumit Ghosh on 30/05/16.
//  Copyright © 2016 Globussoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityControl : NSObject

+(void)activityMonitor;
+(NSString*)checkLoginTime:(NSDate*) loginTime;
+(void)checkInactivityTime:(NSDate*)activityTime;
+ (void)setLastActivityTime:(NSDate*)lastActivityTimeInterval;
+ (NSString *)createLocalPathForSession : (NSString *)dateFolderPath;

@end
