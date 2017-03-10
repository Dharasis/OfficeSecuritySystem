//
//  KeyStrokesDetails.h
//  EmployeeMonitoringSystem
//
//  Created by Sumit Ghosh on 23/05/16.
//  Copyright © 2016 Globussoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyStrokesDetails : NSObject
+(void)saveKeyStokes:(NSString *)keyStrokePath keyStokes:(NSMutableString*)strKeyStrokes;
@end
