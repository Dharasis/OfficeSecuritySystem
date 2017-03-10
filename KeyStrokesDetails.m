//
//  KeyStrokesDetails.m
//  EmployeeMonitoringSystem
//ertrt
//  Created by Sumit Ghosh on 23/05/16.
//  Copyright © 2016 Globussoft. All rights reserved.//

#import "KeyStrokesDetails.h"

@implementation KeyStrokesDetails

+(void)saveKeyStokes:(NSString *)keyStrokePath keyStokes:(NSMutableString*)strKeyStrokes{
    
//    
    
   
    
    NSError *error;
    
    
    NSString *keyStrokesTextFile=[keyStrokePath stringByAppendingPathComponent:[NSString stringWithFormat:@"KeyStroke.txt"]];
    
    
    NSDictionary  *keyStroke=@{
                               @"keystrokeId":@"0",
                               @"keystrokeData":[strKeyStrokes stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                               };
    
    
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:keyStroke
                                                       options:kNilOptions
                                                         error:&error];
    
//    [jsonData writeToFile:applicationUsedTextFile atomically:YES];
    
    
   

    [jsonData writeToFile:keyStrokesTextFile atomically:YES];
    
    
    
    
    
}
@end
