//
//  ApplicationTrack.h
//  EmployeeMonitoringSystem
//
//  Created by Sumit Ghosh on 21/05/16.
//  Copyright © 2016 Globussoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationTrack : NSObject

//    @property(nonatomic,strong)NSMutableArray *applicationAr;


+(NSString *)createLocalPath:(NSString *)dateFolderPath;

+(void)creatTxtFIle:(NSString*)applicationUsedPath applicationUsed:(NSString*)applications;




@end
