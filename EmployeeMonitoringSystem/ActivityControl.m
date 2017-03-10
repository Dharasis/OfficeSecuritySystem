//
//  ActivityControl.m
//  EmployeeMonitoringSystem
//
//  Created by Sumit Ghosh on 30/05/16.
//  Copyright © 2016 Globussoft. All rights reserved.
//

#import "ActivityControl.h"
#import "SingeltonClass.h"

@implementation ActivityControl

static NSDate * lastActivityTime;

static float lastIdleActivityTime;
static int flag=0;
static NSString * datePath;

+(void)activityMonitor{
    
    
    
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask
                                           handler:^(NSEvent *event){
                                               
                                               
                                           lastActivityTime=[NSDate date];
                                               
                                               
                                               // Log(@"typed KeyStrokes %@",strKeyStrokes);
                                               
                                           }];
    
    
    [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask handler:^NSEvent* (NSEvent* event){
        
        
        
        
          lastActivityTime=[NSDate date];
        
        
        
        
        return event;
    }];
    
    

    
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSMouseMovedMask handler:^(NSEvent *mouseMovedEvent) {
     
        
        lastActivityTime=[NSDate date];
        
     // [self checkInactivityTime:[NSDate date]];
        //NSLog(@"Mouse Moved");
        
        //do something with that event
    }];
    
    
    [NSEvent addLocalMonitorForEventsMatchingMask:NSMouseMovedMask handler:^NSEvent* (NSEvent* event){
        
        lastActivityTime=[NSDate date];

        
       // NSLog(@"Mouse Moved when app is active");
        
     //    [self checkInactivityTime:[NSDate date]];
        return event;
        
    }];
    
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseDownMask handler:^(NSEvent *mouseEntered) {
        
        lastActivityTime=[NSDate date];

        
        //   [self checkInactivityTime:[NSDate date]];
        
      //  NSLog(@"Mouse Left Clicked");
        
        //do something with that event
    }];
    
    
    [NSEvent addLocalMonitorForEventsMatchingMask:NSLeftMouseDownMask handler:^NSEvent* (NSEvent* event){
        
       // NSLog(@"Mouse Left Clicked when app is active");
        
        lastActivityTime=[NSDate date];
  
        
    //     [self checkInactivityTime:[NSDate date]];
        
        return event;
        
    }];
    
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSRightMouseDownMask handler:^(NSEvent *mouseEntered) {
        
        
        lastActivityTime=[NSDate date];

        //    [self checkInactivityTime:[NSDate date]];
        
      //  NSLog(@"Mouse Right Clicked");
        
        //do something with that event
    }];
    
    
    [NSEvent addLocalMonitorForEventsMatchingMask:NSRightMouseDownMask handler:^NSEvent* (NSEvent* event){
       
      
        lastActivityTime=[NSDate date];

        //  NSLog(@"Mouse Right Clicked when app is active");
        
        
      //   [self checkInactivityTime:[NSDate date]];
        
        return event;
        
    }];
    
    
    
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSScrollWheelMask handler:^(NSEvent *mouseEntered) {
        
        
        lastActivityTime=[NSDate date];

        
       //  [self checkInactivityTime:[NSDate date]];
        
      //  NSLog(@"Mouse Scrolled");
        
        //do something with that event
    }];
    
    
    [NSEvent addLocalMonitorForEventsMatchingMask:NSScrollWheelMask handler:^NSEvent* (NSEvent* event){
        
     //   NSLog(@"Mouse Scrolled when app is active");
        
        
        lastActivityTime=[NSDate date];

        
        
         //[self checkInactivityTime:[NSDate date]];
        
        return event;
        
    }];
}

+  (void)checkInactivityTime:(NSDate*)activityTime{
    
    
//    NSDateFormatter *date=[[NSDateFormatter alloc]init];
//    [date setDateFormat :@"dd-MMM-yyyy hh:mm:ss a"];
//    [date setTimeZone:[NSTimeZone systemTimeZone]];
  
    
    NSLog(@"=====================================================");
    
                NSLog(@"LastActivityTime %@",lastActivityTime);
                NSLog(@"Now check TIme %@",activityTime);
    
    NSLog(@"=====================================================");
    
    
    //difference between lastActivityTime and now time
    
    NSTimeInterval secondsBetween = [activityTime  timeIntervalSinceDate:lastActivityTime];
    
    float differenceMin=secondsBetween/60;
   
    
    NSLog(@"====================Inactivity time Difference %.02f===============",differenceMin);
    
    //if difference between time interval is more than 1 min
    
    if(differenceMin>3){
        
        
        flag=0;
        
        lastIdleActivityTime=differenceMin;
        
        
        
        
        
           NSLog(@"====================Inactivity time Difference After 1 min %.02f===============",differenceMin);
        
      //  NSLog(@"====================Inactivity time %f===============",[SingeltonClass sharedSingleton].inactivityTime);
        
    } else {
        
        
        
        

        
        
        if(flag==0){
            flag=1;
            
            [SingeltonClass sharedSingleton].inactivityTime=[SingeltonClass sharedSingleton].inactivityTime+lastIdleActivityTime;
            
            lastIdleActivityTime=0;
            
            NSLog(@"Idle Time -------------------> %@",[self stringFromMinute:[SingeltonClass sharedSingleton].inactivityTime]);
            
        }
        
        
        
        
    }

    
    [self calculateWorkingTime:activityTime];

    
    
//    lastActivityTime=activityTime;
    [self creatTxtFIle:[self createLocalPathForSession:datePath]];
    
    
}

+ (NSString*)checkLoginTime:(NSDate*) loginTime{
    
    
    
    
    
    
    lastActivityTime=loginTime;
    
    
//    NSDateFormatter *date=[[NSDateFormatter alloc]init];
//    [date setDateFormat :@"dd-MMM-yyyy hh:mm:ss a"];
//    [date setTimeZone:[NSTimeZone systemTimeZone]];
   
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[self convertToLocal:loginTime] forKey:@"LoginTime"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    return [self convertToLocal:loginTime];
}



+(void)calculateWorkingTime:(NSDate*)nowTime{
    
    
    
    NSLog(@"LoginTime %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginTime"]);
    
    //Convert String to date Object
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
   
    NSDate *loginTime=[dateFormat dateFromString:[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginTime"]];
    
    
    
    
    NSDate *nowDateFormat=[dateFormat dateFromString:[self convertToLocal:nowTime]];
    
    
      NSTimeInterval secondsBetween = [nowDateFormat  timeIntervalSinceDate:loginTime];
    
    
   // NSLog(@"Non-Working in min %f",[SingeltonClass sharedSingleton].inactivityTime);
    
    NSTimeInterval workingHour=secondsBetween-([SingeltonClass sharedSingleton].inactivityTime*60);
    

   // NSLog(@"Working Hours %@",[self stringFromTimeInterval:workingHour]);
    
    
    [SingeltonClass sharedSingleton].workingInterVal=[self stringFromTimeInterval:workingHour];

    [SingeltonClass sharedSingleton].totalTime=[self stringFromTimeInterval:secondsBetween];
    
 
    
    
}

+(NSString*)convertToLocal:(NSDate*)time{
    
    NSDateFormatter *date1=[[NSDateFormatter alloc]init];
    [date1 setDateFormat :@"dd-MM-yyyy HH:mm:ss"];
    [date1 setTimeZone:[NSTimeZone systemTimeZone]];
    
    return [date1 stringFromDate:time];
    

    
}




+ (void)setLastActivityTime:(NSDate*)lastActivityTimeInterval
{
    lastActivityTime=lastActivityTimeInterval;
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}


+ (NSString*)stringFromMinute:(float)minute{
    
    
    NSInteger ti=minute*60;
    
    
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];

    
}

+ (NSString *)createLocalPathForSession : (NSString *)dateFolderPath{
    
    
   
    
    datePath=dateFolderPath;
    
    NSError *error;
    
    NSString *getPathSessions  =[dateFolderPath stringByAppendingPathComponent:@"/Sessions"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:getPathSessions])
    {
[[NSFileManager defaultManager] createDirectoryAtPath:getPathSessions withIntermediateDirectories:NO attributes:nil error:&error
         ];
        
    }
    
    return getPathSessions;
    
}


+ (void)creatTxtFIle:(NSString*)sessionPath {
    
    
    NSString *sessionTextFile=[sessionPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Session.txt"]];
    NSError *error;
    
    
    
    //{"logsheetId":"","dateOfEntry":"21-May-2016","loginTime":"21-May-2016 10:00:43 AM","logoutTime":"21-May-2016 02:41:06 PM","loginTimeUtc":"21-May-2016 04:30:43 AM","logoutTimeUtc":"21-May-2016 09:11:06 AM","workingHours":"03:54:10","nonWorkingHours":"00:46:12","totalHours":"04:40:22","userId":0,"lastUpdateTime":"21-May-2016 14:41:06","isReportGenerated":false}
   
    
    
//    sessionDict=[[NSDictionary alloc]init];
    
    
//    NSLog(@"login Time %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"LoginTime"]);
//    NSLog(@"WorkingTime %@",[SingeltonClass sharedSingleton].workingInterVal);
//    NSLog(@"Non Working %@",[self stringFromMinute:[SingeltonClass sharedSingleton].inactivityTime]);
//    NSLog(@"total Time %@",[SingeltonClass sharedSingleton].totalTime);
    
    
    
   NSDictionary * sessionDict=
  
              @{
                                 
                       @"logsheetId":@"",
                       @"dateOfEntry":@"",
                       @"loginTime":[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginTime"],
                       @"logoutTime":@"" ,
                       @"loginTimeUtc":@"",
                       @"logoutTimeUtc":@"",
                       @"workingHours":[SingeltonClass sharedSingleton].workingInterVal,
                       @"nonWorkingHours":[self stringFromMinute:[SingeltonClass sharedSingleton].inactivityTime],
                       @"totalHours":[SingeltonClass sharedSingleton].totalTime ,
                       @"userId":@"0",
                       @"lastUpdateTime":[self convertToLocal:[NSDate date]],
                       @"isReportGenerated":@"false"
                       
                };
    
    
   
    
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:sessionDict
                                                       options:kNilOptions
                                                         error:&error];
    
    [jsonData writeToFile:sessionTextFile atomically:YES];
    
    
    // [[SingeltonClass sharedSingleton].applicationAr writeToFile:applicationUsedTextFile atomically:NO];
    
    
    
    
    
    
    
}

-(NSString*)fetchdate:(NSString *)dateStr{
    
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    // [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //
    NSDate *date=[dateFormat dateFromString:dateStr];
    
    
    
    NSDateFormatter *utc=[[NSDateFormatter alloc]init];
    //[utc setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [utc setTimeZone:[NSTimeZone localTimeZone]];
    //  NSString *utcstr=[utc stringFromDate:date];
    
    [utc setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * resultDate =[utc stringFromDate:date];
    
    
    return resultDate;
    
}




@end
