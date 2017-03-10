//
//  WhiteView.m
//  EmployeeMonitoringSystem
//
//  Created by GBS-mac on 12/15/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "WhiteView.h"

@implementation WhiteView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    CGContextRef context=(CGContextRef)[NSGraphicsContext currentContext].graphicsPort;
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context,dirtyRect);
    
    
    // Drawing code here.
}

@end
