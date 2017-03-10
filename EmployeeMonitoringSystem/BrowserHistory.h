//
//  BrowserHistory.h
//  EmployeeMonitoringSystem
//
//  Created by Sumit Ghosh on 24/05/16.
//  Copyright © 2016 Globussoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface BrowserHistory : NSObject
{
    
     sqlite3 *databaseMoz,*databaseChrome,*databaseSafari;
    
}
-(void)getMozillaHistory:(NSString*)localPath;
-(void)getChromeHistory:(NSString*)localPath;
-(void)getSafariHistory:(NSString*)localPath;


@end
