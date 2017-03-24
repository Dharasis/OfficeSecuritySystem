//
//  AppDelegate.m
//  EmployeeMonitoringSystem
//
//  Created by GBS-mac on 12/13/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "AppDelegate.h"
#import "SingeltonClass.h"
#import "MediaFireSDK.h"
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    
    
    NSString* appID = @"53714";
    NSString* apiKey = @"wcrpy2ql1ylztwbb4ywbla06tleca2r60snil1lu"; // May be blank if "Require Secret Key" is disabled.
    
    [MediaFireSDK createWithConfig:@{@"app_id"  : appID,
                                     @"api_key" : apiKey}];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSignInName) name:@"changeSignInName" object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAppFrame) name:@"changeApplicationFrame" object:nil];

   // if([[NSUserDefaults standardUserDefaults] boolForKey:@"HideDockIcon"])
    
    
//    
    // Insert code here to initialize your application
    
    [self getSerialNumber];

    
    [self.window resignMainWindow];
    mainWindowCon=[[MainWindowController alloc]initWithWindowNibName:@"MainWindowController"];
    [mainWindowCon.window makeMainWindow];
    [mainWindowCon showWindow:self];
    
    
    
    NSLog(@"Sudip");
    
    

}
- (void)applicationWillTerminate:(NSNotification *)notification;
{
    NSLog(@"App Closed");
}

-(void)getSerialNumber
{
    CFStringRef *serialNum;
    if (serialNum != NULL) {
        serialNum=NULL;
    }
    io_service_t    platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault,IOServiceMatching("IOPlatformExpertDevice"));
    
    if (platformExpert) {
        CFTypeRef serialNumberAsCFString =
        IORegistryEntryCreateCFProperty(platformExpert,
                                        CFSTR(kIOPlatformSerialNumberKey),
                                        kCFAllocatorDefault, 0);
        if (serialNumberAsCFString) {
            
            NSString *str=(__bridge NSString *)serialNumberAsCFString;
            NSLog(@"Serial Num==%@",str);
            [SingeltonClass sharedSingleton].macID=str;
            
            
        }
        
        IOObjectRelease(platformExpert);
    }
}
extern void MFCaptureLogMessage(NSString* message) {
    // Use this method to capture log messages from MediaFire SDK.
}


-(void)changeAppFrame{
    
    [mainWindowCon.window setFrame:NSMakeRect(0.f,0.f,0.f,0.f) display:YES animate:YES];
      [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
    
    
}


@end
