//
//  NextPageViewController.m
//  EmployeeMonitoringSystem
//
//  Created by GBS-mac on 12/13/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "NextPageViewController.h"
#import "SettingViewController.h"

@interface NextPageViewController ()

@end

@implementation NextPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        settings=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
        
    }
    return self;
}
- (IBAction)settingBtnAction:(id)sender {
    [self.pageView removeFromSuperview];
    [self.view addSubview:settings.view];
    
}

- (IBAction)signOutBtnAction:(id)sender {
    NSLog(@"Log In Date==%@",self.logInDate);
    signOutDate=[NSDate date];
    NSLog(@"Log Out Date==%@",signOutDate);
    arrMozHistory=[[NSMutableArray alloc]init];
    arrChromeHistory=[[NSMutableArray alloc]init];
    [self getMozillaHistory];
    [self getChromeHistory];
    
}

-(void)getMozillaHistory
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,NSUserDomainMask,YES);
    NSString *dirPath=[paths objectAtIndex:0];
    NSString *path1=[dirPath stringByAppendingPathComponent:@"Firefox"];
    NSString *path2=[path1 stringByAppendingPathComponent:@"Profiles"];
    NSString *path3=[path2 stringByAppendingPathComponent:@"3hte6kwq.default"];
    NSString *finaldbPath=[path3 stringByAppendingPathComponent:@"places.sqlite"];
    NSLog(@"Path==%@",finaldbPath);
    const char *query="SELECT url,last_visit_date,id,title FROM moz_places order by id desc limit 1";
    static sqlite3_stmt *statement;
    if (sqlite3_open([finaldbPath UTF8String],&databaseMoz)!=SQLITE_OK) {
        NSLog(@"Error to open");
    }
    if (sqlite3_prepare_v2(databaseMoz,query, -1,&statement,NULL)==SQLITE_OK) {
        NSLog(@"Prepared");
    }
    while (sqlite3_step(statement)==SQLITE_ROW)
    {
        
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
            
            NSLog(@"Last opened : %@",dateVisit);
               
                [arrMozHistory addObject:strUrl];
            //}
        }
    }
    sqlite3_close(databaseMoz);

    NSLog(@"Moz History==%@",arrMozHistory);

}
-(void)getChromeHistory
{
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,NSUserDomainMask,YES);
    NSString *dirPath=[paths objectAtIndex:0];
    NSString *path1=[dirPath stringByAppendingPathComponent:@"Google"];
    NSString *path2=[path1 stringByAppendingPathComponent:@"Chrome"];
    NSString *path3=[path2 stringByAppendingPathComponent:@"Default"];
    NSString *finaldbPath=[path3 stringByAppendingPathComponent:@"History"];
    
    NSLog(@"Path==%@",finaldbPath);
    
    
    if(sqlite3_open([finaldbPath UTF8String],&databaseChrome)==SQLITE_OK)
    {
        NSString *query=[NSString stringWithFormat:@"SELECT url,last_visit_time,id,title FROM urls order by id desc limit 1"];
        //order by id desc limit 1
        
        sqlite3_stmt  *statement;
        const char *select_statement=[query UTF8String];
        if( sqlite3_prepare_v2(databaseChrome, select_statement, -1, &statement, NULL)==SQLITE_OK){

        
            if(sqlite3_step(statement)==SQLITE_ROW)
        {
            
            //NSString *add=[[NSString alloc]initWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];
            
         int timestmp=(const char)sqlite3_column_int(statement, 1);
            
            NSLog(@"URL -> %s \n time -> %d  ID %d",(const char*)sqlite3_column_text(statement, 0),timestmp,sqlite3_column_int(statement, 2));
        
            NSLog(@"Title %s",(const char*)sqlite3_column_text(statement, 3));
            
            
            char *urlChars = (char *) sqlite3_column_text(statement, 1);
           // int timestmp=sqlite3_column_double(statement, 5);
            
            if (timestmp !=0 ) {
                
                
                
                
                NSDateComponents *base = [[NSDateComponents alloc] init];
                [base setDay:1];
                [base setMonth:1];
                [base setYear:1601];
                [base setEra:1]; // AD
                
                NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                
                NSDate *baseDate = [gregorian dateFromComponents:base];
                
                NSString *strtimestmp=[NSString stringWithFormat:@"%d",timestmp];
                strtimestmp=[strtimestmp substringToIndex:10];
                NSTimeInterval interval=[strtimestmp doubleValue];
                
                
                NSTimeInterval timestamp = interval / 10000000.0;
                
                NSDate *finalDate = [baseDate dateByAddingTimeInterval:timestamp];

                NSLog(@"Date===%@",finalDate);

//                if (([dateVisit compare:self.logInDate]==NSOrderedDescending) && ([dateVisit compare:signOutDate]==NSOrderedAscending)) {
                    NSString *strUrl=[NSString stringWithFormat:@"%s",urlChars];
                    
                    [arrChromeHistory addObject:strUrl];
                    
                    
               // }
            }

            
            
        }
        }else{
            NSLog(@"Error %s",sqlite3_errmsg(databaseChrome));
        }
        sqlite3_finalize(statement);
       

    }
    
    sqlite3_close(databaseChrome);

    NSLog(@"Chrome History==%@",arrChromeHistory);

}

@end
