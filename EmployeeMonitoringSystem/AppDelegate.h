//
//  AppDelegate.h
//  EmployeeMonitoringSystem
//
//  Created by GBS-mac on 12/13/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    MainWindowController *mainWindowCon;
    
}

@property (assign) IBOutlet NSWindow *window;

@end
