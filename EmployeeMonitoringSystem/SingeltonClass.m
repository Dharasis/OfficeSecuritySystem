//
//  SingeltonClass.m
//  EmployeeMonitoringSystem
//
//  Created by GBS-mac on 12/24/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "SingeltonClass.h"

@implementation SingeltonClass

static SingeltonClass *sharedSingleton;
+(SingeltonClass*)sharedSingleton {
    
    @synchronized(self){
        
        if(!sharedSingleton){
            sharedSingleton=[[SingeltonClass alloc]init];
        }
    }
    return sharedSingleton;
}
+(BOOL)networkcheck{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    //BOOL netWorkConnection;
    if(status == NotReachable)
    {
        //netWorkConnection=NO;
        return NO;
    }
    else if (status == ReachableViaWiFi){
        //   netWorkConnection=YES;
        return YES;
    }else if (status==ReachableViaWWAN){
        //  netWorkConnection=YES;
        return YES;
        
    }else
        // netWorkConnection=NO;
        return NO;
    
    
    // [[NSUserDefaults standardUserDefaults] setBool:netWorkConnection forKey:@"ConnectionAvilable"];
}

@end
