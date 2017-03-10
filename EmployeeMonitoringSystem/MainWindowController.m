//
//  MainWindowController.m
//  EmployeeMonitoringSystem
//
//  Created by GBS-mac on 12/13/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "MainWindowController.h"
#import "AppDelegate.h"
#import "LogInViewController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissVC) name:@"afterLogIn" object:nil];
        
         logInViewCon=[[LogInViewController alloc]initWithNibName:@"LogInViewController" bundle:nil];
        
        
    }
    return self;
}
- (void)windowDidLoad
{
    [super windowDidLoad];
    
     
//    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask handler:^(NSEvent *keyEvent)
//     {
//     NSLog( @"Command was pressed" );
//     
//     }];

    
    
    
    
  
    [self.window setBackgroundColor:[NSColor colorWithCalibratedRed:(CGFloat)77/255 green:(CGFloat)31/255 blue:(CGFloat)3/255 alpha:1.0]];
    [self.window setMaxSize:NSSizeFromCGSize(CGSizeMake(900,900))];
   
    [self.window.contentView addSubview:logInViewCon.view];
// Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)dismissVC{
        
    

}


@end
