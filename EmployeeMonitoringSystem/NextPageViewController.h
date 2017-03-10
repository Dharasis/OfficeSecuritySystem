//
//  NextPageViewController.h
//  EmployeeMonitoringSystem
//
//  Created by GBS-mac on 12/13/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WhiteView.h"
#import "SettingViewController.h"
#import <sqlite3.h>

@interface NextPageViewController : NSViewController
{
    SettingViewController *settings;
    NSDate *signOutDate;
    sqlite3 *databaseMoz,*databaseChrome;
    NSMutableArray *arrMozHistory,*arrChromeHistory;
}

@property (strong) IBOutlet WhiteView *popUpView;
@property (strong) IBOutlet NSView *pageView;
@property (nonatomic,strong) NSDate *logInDate;
-(void)getMozillaHistory;
-(void)getChromeHistory;

@end
