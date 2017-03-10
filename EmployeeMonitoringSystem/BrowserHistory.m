//
//  BrowserHistory.m
//  EmployeeMonitoringSystem
//
//  Created by Sumit Ghosh on 24/05/16.
//  Copyright © 2016 Globussoft. All rights reserved.
//

#import "BrowserHistory.h"
#import "SingeltonClass.h"

@implementation BrowserHistory


-(void)getMozillaHistory:(NSString*)localPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,NSUserDomainMask,YES);
    NSString *dirPath=[paths objectAtIndex:0];
    NSString *path1=[dirPath stringByAppendingPathComponent:@"Firefox"];
    NSString *path2=[path1 stringByAppendingPathComponent:@"Profiles"];
    NSString *path3=[path2 stringByAppendingPathComponent:@"3hte6kwq.default"];
    NSString *finaldbPath=[path3 stringByAppendingPathComponent:@"places.sqlite"];
   // NSLog(@"Path==%@",finaldbPath);
    
    
    NSString *queryStr=[NSString stringWithFormat:@"SELECT url,last_visit_date,id,title FROM moz_places WHERE last_visit_date > \"%ld\" AND last_visit_date <= \"%ld\"",[self convertToUnixTimeStamp:[self getMidNightTime]],[self convertToUnixTimeStamp:[NSDate date]]];
    
    const char *query=[queryStr UTF8String];
    static sqlite3_stmt *statement;
    if (sqlite3_open([finaldbPath UTF8String],&databaseMoz)!=SQLITE_OK) {
        NSLog(@"Error to open");
    }
    if (sqlite3_prepare_v2(databaseMoz,query, -1,&statement,NULL)==SQLITE_OK) {
        NSLog(@"Prepared");
    }else{
        NSLog(@"Firefox Error %s",sqlite3_errmsg(databaseSafari));
    }
    while (sqlite3_step(statement)==SQLITE_ROW)
    {
        
        
        
       // [self createLocalPath:localPath];
        
        
        
        
        //For url and Time stamp
        char *urlChars = (char *) sqlite3_column_text(statement, 0);
        double timestmp=sqlite3_column_double(statement, 1);
        if (timestmp !=0) {
            NSString *strtimestmp=[NSString stringWithFormat:@"%f",timestmp];
            strtimestmp=[strtimestmp substringToIndex:10];
            NSTimeInterval interval=[strtimestmp doubleValue];
            NSDate *dateVisit=[NSDate dateWithTimeIntervalSince1970:interval];
            //            if (([dateVisit compare:self.logInDate]==NSOrderedDescending) && ([dateVisit compare:signOutDate]==NSOrderedAscending)) {
            NSString *strUrl=[NSString stringWithFormat:@"%s",urlChars];
            
//            NSLog(@"Last opened : %@",[self convertDate:dateVisit]);
//            NSLog(@"Url %@",strUrl);
            
            
            
            [self saveToLocal:@"Firefox" url:strUrl time:[self convertDate:dateVisit] browserHistPath:[self createLocalPath:localPath]];
            
            
            //}
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(databaseMoz);
    
 
    
}


-(void)getChromeHistory:(NSString*)localPath
{
 
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,NSUserDomainMask,YES);
    NSString *dirPath=[paths objectAtIndex:0];
    NSString *path1=[dirPath stringByAppendingPathComponent:@"Google"];
    NSString *path2=[path1 stringByAppendingPathComponent:@"Chrome"];
    NSString *path3=[path2 stringByAppendingPathComponent:@"Default"];
    NSString *finaldbPath=[path3 stringByAppendingPathComponent:@"History"];
    
    //NSLog(@"Path==%@",finaldbPath);
    NSString *queryStr=[NSString stringWithFormat:@"SELECT url,last_visit_time,id,title FROM urls WHERE  last_visit_time > \"%ld\" AND last_visit_time <= \"%ld\"",[self convertToWebKitTimeStamp:[self getMidNightTime]],[self convertToWebKitTimeStamp:[NSDate date]]];
    
         const char *query=[queryStr UTF8String];
        //order by id desc limit 1
        
    static    sqlite3_stmt  *statement1;
      //  const char *select_statement=[query UTF8String];
        
        if (sqlite3_open([finaldbPath UTF8String],&databaseChrome)==SQLITE_OK) {
            NSLog(@"DB open");
        
        if (sqlite3_prepare_v2(databaseChrome,query, -1,&statement1,NULL)==SQLITE_OK) {
            NSLog(@"Prepared");
        }else{
            NSLog(@"Chrome Error %s",sqlite3_errmsg(databaseChrome));
        }
        
     //   if( sqlite3_prepare_v2(databaseChrome, select_statement, -1, &statement, NULL)==SQLITE_OK){
            
            
            while(sqlite3_step(statement1)==SQLITE_ROW)
            {
                
                
                
                
                
                
                
                
                //NSString *add=[[NSString alloc]initWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];
                
                double timestmp=sqlite3_column_double(statement1, 1);
                
//                NSLog(@"URL -> %s \n time -> %f  ID %d",(const char*)sqlite3_column_text(statement1, 0),timestmp,sqlite3_column_int(statement1, 2));
//                
//                NSLog(@"Title %s",(const char*)sqlite3_column_text(statement1, 3));
                
                
                char *urlChars = (char *) sqlite3_column_text(statement1, 0);
                // int timestmp=sqlite3_column_double(statement, 5);
                
                if (timestmp !=0 ) {
                    
                    
                    

                    
                    NSDate *baseeDate=[NSDate dateWithNaturalLanguageString:@"1601-01-01 00:00"];
                    
                    NSString *strtimestmp=[NSString stringWithFormat:@"%f",timestmp];
                   // strtimestmp=[strtimestmp substringToIndex:10];
                    NSTimeInterval interval=[strtimestmp doubleValue];
                    
                    
                    NSTimeInterval timestamp = interval / 1000000.0;
                    
                    NSDate *finalDate = [baseeDate dateByAddingTimeInterval:timestamp];
                    
                //    NSLog(@"Date===%@",[self convertDate:finalDate]);
               
                    NSString *strUrl=[NSString stringWithFormat:@"%s",urlChars];
                    
                //    NSLog(@"URL %@",strUrl);
//
                    
                    
                    
                    
                    [self saveToLocal:@"Google Chrome" url:strUrl time:[self convertDate:finalDate] browserHistPath:[self createLocalPath:localPath]];
                    
                    
                    
                    // }
                }
              

                
                
                
            }
            
            sqlite3_finalize(statement1);
            sqlite3_close(databaseChrome);
        }
  
    
    
}




#pragma mark-Fetch safari History

-(void)getSafariHistory:(NSString*)localPath{
    
    
    
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    NSString *dirPath=[paths objectAtIndex:0];
    NSString *path1=[dirPath stringByAppendingPathComponent:@"Safari"];
    NSString *finaldbPath=[path1 stringByAppendingPathComponent:@"History.db"];
//    NSString *path3=[path2 stringByAppendingPathComponent:@"Default"];
//    NSString *finaldbPath=[path3 stringByAppendingPathComponent:@"History"];
    
  //  NSLog(@"Path==%@",finaldbPath);
    NSString *queryStr=[NSString stringWithFormat:@"select hi.url, hv.visit_time from history_items hi join history_visits hv  on hi.id = hv.history_item where hv.visit_time  > \"%f\" AND hv.visit_time <= \"%f\"",[self convertToSafariTimeStamp:[self getMidNightTime]],[self convertToSafariTimeStamp:[NSDate date]]];
    
    const char *query=[queryStr UTF8String];
    //order by id desc limit 1
    
    static    sqlite3_stmt  *statement1;
    //  const char *select_statement=[query UTF8String];
    
    if (sqlite3_open([finaldbPath UTF8String],&databaseSafari)==SQLITE_OK) {
        NSLog(@"DB open");
        
        if (sqlite3_prepare_v2(databaseSafari,query, -1,&statement1,NULL)==SQLITE_OK) {
            NSLog(@"Prepared");
        }else{
            NSLog(@"Safari Error %s",sqlite3_errmsg(databaseSafari));
        }
        
        //   if( sqlite3_prepare_v2(databaseChrome, select_statement, -1, &statement, NULL)==SQLITE_OK){
        
        
        while(sqlite3_step(statement1)==SQLITE_ROW)
      
        {
            
            
            
            
            
            
            
            
            //NSString *add=[[NSString alloc]initWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];
            
           // double timestmp=sqlite3_column_double(statement1, 1);
            
                       NSLog(@"URL -> %s \n time -> %s  ID %d",(const char*)sqlite3_column_text(statement1, 0),(const char*)sqlite3_column_text(statement1, 1),sqlite3_column_int(statement1, 2));
            //
            //                NSLog(@"Title %s",(const char*)sqlite3_column_text(statement1, 3));
            
            
     char *urlChars = (char *) sqlite3_column_text(statement1, 0);
             double timestmp=sqlite3_column_double(statement1, 1);
            
            if (timestmp !=0 ) {
                
                
                
                
                
                NSDate *baseeDate=[NSDate dateWithNaturalLanguageString:@"2001-01-01 00:00"];
                
                NSString *strtimestmp=[NSString stringWithFormat:@"%f",timestmp];
                // strtimestmp=[strtimestmp substringToIndex:10];
                NSTimeInterval interval=[strtimestmp doubleValue];
                
                
               
                NSDate *finalDate = [baseeDate dateByAddingTimeInterval:interval];
                
                //    NSLog(@"Date===%@",[self convertDate:finalDate]);
                
                NSString *strUrl=[NSString stringWithFormat:@"%s",urlChars];
                
                //    NSLog(@"URL %@",strUrl);
                //
                
                
                
                
                [self saveToLocal:@"Safari" url:strUrl time:[self convertDate:finalDate] browserHistPath:[self createLocalPath:localPath]];
                
                
                
                // }
            }
            
            
            
            
            
        }
        
        sqlite3_finalize(statement1);
        sqlite3_close(databaseSafari);
    }
    
    
    
}






-(NSString*)convertDate:(NSDate *)utcDate{
    
    
    
    NSDateFormatter *utc=[[NSDateFormatter alloc]init];
    //[utc setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    [utc setTimeZone:[NSTimeZone localTimeZone]];
    //  NSString *utcstr=[utc stringFromDate:date];
    [utc setDateFormat:@"dd-MMM-yyyy hh:mm:ss a"];
    NSString * resultDate =[utc stringFromDate:utcDate];
    return resultDate;
    
}



-(long)convertToWebKitTimeStamp:(NSDate*)convertDate{
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"] ;
    NSDate *date = convertDate;
    NSLog(@"date=%@",date) ;
    NSTimeInterval interval1  = [date timeIntervalSinceDate:[NSDate dateWithNaturalLanguageString:@"1601-01-01 00:00"]] ;
    NSLog(@"interval=%f",interval1*1000000) ;
    return interval1*1000000;
   
}



-( float)convertToSafariTimeStamp:(NSDate*)convertDate{
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"] ;
    NSDate *date = convertDate;
    NSLog(@"date=%@",date) ;
    NSTimeInterval interval1  = [date timeIntervalSinceDate:[NSDate dateWithNaturalLanguageString:@"2001-01-01 00:00"]] ;
    NSLog(@"safari interval=%f",interval1) ;
    return interval1;
    
}


-(long)convertToUnixTimeStamp:(NSDate*)date{
    
    
  
    NSTimeInterval interval  = [date timeIntervalSince1970] ;
      NSDate *methodStart = [NSDate dateWithTimeIntervalSince1970:interval] ;
  long long timeStamp = (long long)([methodStart timeIntervalSince1970]);
   
    NSLog(@"FireFox %lld",timeStamp*1000000);
    
    return timeStamp*1000000;
    
    
}

-(NSDate*)getMidNightTime
{
    
    NSDate *const date = NSDate.date;
    NSCalendar *const calendar = NSCalendar.currentCalendar;
    NSCalendarUnit const preservedComponents = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    NSDateComponents *const components = [calendar components:preservedComponents fromDate:date];
    NSDate *const normalizedDate = [calendar dateFromComponents:components];
    
    return normalizedDate;
    
 }

#pragma mark-save browser history to local .txt file
-(void)saveToLocal:(NSString*)browserName url:(NSString*)urlName time:(NSString*)timeOfVisit browserHistPath:(NSString*)browserHistPath{
    
    
    
    
    NSString *browserHistoryTextFile=[browserHistPath stringByAppendingPathComponent:[NSString stringWithFormat:@"BrowserHistory.txt"]];
    

    
    
    //[{"browserHistoryId":0,"timeStamp":"21-May-2016 10:35:03 AM","browser":"Google Chrome","url":"https://www.facebook.com/"}]e12
    
    NSDictionary *historyDict=@{
                                @"browserHistoryId":@"0",
                                @"timeStamp":timeOfVisit,
                                @"browser":browserName,
                                @"url":urlName
                                };
    
    [[SingeltonClass sharedSingleton].browserHistAr addObject:historyDict];
    
    
    NSError* error;
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[SingeltonClass sharedSingleton].browserHistAr
                                                       options:kNilOptions
                                                         error:&error];
    
    [jsonData writeToFile:browserHistoryTextFile atomically:YES];

    
}
-(NSString *)createLocalPath:(NSString *)dateFolderPath{
    
    
    NSError *error;
    
    NSString *getPathBrowserHistory  =[dateFolderPath stringByAppendingPathComponent:@"/BrowserHistories"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:getPathBrowserHistory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:getPathBrowserHistory withIntermediateDirectories:NO attributes:nil error:&error
         ];
        
    }
    
    
    
//   NSLog(@"%@",getPathBrowserHistory);
    
    return getPathBrowserHistory;
    
    
    
}



@end
