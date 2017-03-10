//
//  LogInViewController.h
//  EmployeeMonitoringSystem
//
//  Created by GBS-mac on 12/13/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NextPageViewController.h"
#import "KeyStrokesDetails.h"
#import "ActivityControl.h"
#import "BrowserHistory.h"


@interface LogInViewController : NSViewController
{
    NSButton *logInBtn;
    NextPageViewController *tablePage;
    BrowserHistory *browserHistory;
    __weak NSView *_customImgView;
    CGDirectDisplayID *displays;
    NSInteger time;
    NSTimer *timer;
    NSImage *storeImg;

}
@property (strong) IBOutlet NSTextField *txtFEmail;
@property (strong) IBOutlet NSSecureTextField *txtFPassword;
@property (strong) IBOutlet NSButton *remembermeBtn;
@property (strong) IBOutlet NSButton *logInButton;
@property (strong) IBOutlet NSView *logInView;
@property (weak) IBOutlet NSView *customImgView;
@property(nonatomic,strong)NSString *getDateFolder;
@property(nonatomic,strong)NSString *getPathKeyStrokes;
@property(nonatomic,strong)NSMutableString * applicationList;


@end
