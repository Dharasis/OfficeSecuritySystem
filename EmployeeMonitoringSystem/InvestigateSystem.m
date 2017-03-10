//
//  InvestigateSystem.m
//  EmployeeMonitoringSystem
//
//  Created by Sumit Ghosh on 13/02/16.
//  Copyright © 2016 Globussoft. All rights reserved.
//

#import "InvestigateSystem.h"

@implementation InvestigateSystem
#pragma mark-Inspect keyStroke
-(void)inspectKeyStrokes
{
    
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSFlagsChangedMask
                                           handler:^(NSEvent* aEvent){
                                               if( [aEvent modifierFlags] & NSCommandKeyMask )
                                               {                                                  NSLog( @"Command was pressed GLOBAL" );
                                               }
                                           }];
    
    //    [NSEvent addLocalMonitorForEventsMatchingMask:NSFlagsChangedMask
    //                                          handler:^(NSEvent* aEvent){
    //                                              if( [aEvent modifierFlags] | NSCommandKeyMask | NSAlphaShiftKeyMask
    //                                                | NSShiftKeyMask
    //                                                | NSControlKeyMask
    //                                                | NSAlternateKeyMask
    //                                                | NSCommandKeyMask
    //                                                | NSKeyDown
    //                                                | NSHelpKeyMask       | NSFunctionKeyMask                                                  )
    //                                            {
    //                                               NSLog( @"Command was pressed LOCAL" );
    //                                           }
    //                                              return aEvent;
    //                                          }];
    [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask handler:^NSEvent* (NSEvent* event){
        NSString *keyPressed = event.characters;
        
        NSLog(@"Pressed %@",keyPressed);
        return event;
    }];
}


@end
