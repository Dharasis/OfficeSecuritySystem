//
//  MainWindowController.h
//  EmployeeMonitoringSystem
//
//  Created by GBS-mac on 12/13/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LogInViewController.h"
@interface MainWindowController : NSWindowController
{
     LogInViewController *logInViewCon;
}
@property (strong) IBOutlet NSView *mainView;



@end
