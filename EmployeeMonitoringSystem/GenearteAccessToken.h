//
//  GenearteAccessToken.h
//  EmployeeMonitoringSystem
//
//  Created by Sumit Ghosh on 08/02/16.
//  Copyright © 2016 Globussoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GenearteAccessToken : NSObject


-(NSString *)generateAccessTok:(NSString*)params;
-(NSString*)decrypt:(NSString*)params;
-(NSData*)encrypt:(NSString*)params;
@end
