//
//  ApplicationTrack.m
//  EmployeeMonitoringSystem
//
//  Created by Sumit Ghosh on 21/05/16.
//  Copyright © 2016 Globussoft. All rights reserved.
//

#import "ApplicationTrack.h"
#import "SingeltonClass.h"

@implementation ApplicationTrack




+(NSString *)createLocalPath:(NSString *)dateFolderPath{
    
    
    NSError *error;
    
    NSString *getPathApplicationsUsed  =[dateFolderPath stringByAppendingPathComponent:@"/ApplicationsUsed"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:getPathApplicationsUsed])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:getPathApplicationsUsed withIntermediateDirectories:NO attributes:nil error:&error];
        
    
    }
    

    
    return getPathApplicationsUsed;

    
    
}

+(void)creatTxtFIle:(NSString*)applicationUsedPath applicationUsed:(NSString*)applications{
  
    
    NSString *applicationUsedTextFile=[applicationUsedPath stringByAppendingPathComponent:[NSString stringWithFormat:@"ApplicationsUsed.txt"]];
    NSError *error;
    
    
    
    
    //fetching the application lunched time

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MMM-dd hh:mm:ss a "];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    
    NSDictionary *applicationDict=[[NSDictionary alloc]init];
   
    
    applicationDict= @{
                      @"applicationUsedId":@"0",
                      @"timeStamp":[dateFormatter stringFromDate:[NSDate date]],
                      @"applicationName":applications
                      };
    
    
    [[SingeltonClass sharedSingleton].applicationAr addObject:applicationDict];
    
  
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[SingeltonClass sharedSingleton].applicationAr
                                                       options:kNilOptions
                                                         error:&error];
  
    [jsonData writeToFile:applicationUsedTextFile atomically:YES];
    
    
   // [[SingeltonClass sharedSingleton].applicationAr writeToFile:applicationUsedTextFile atomically:NO];
    
    
    
    
    
    

}


//
//
//-(void)appActivated:(NSNotification*) notification {
//    
//    NSRunningApplication* currentApp = [notification.userInfo valueForKey:NSWorkspaceApplicationKey];
//  
//}

@end
