//	j
//  MediaFireInit.m
//  EmployeeMonitoringSystem
//
//  Created by Sumit Ghosh on 11/02/16.
//  Copyright © 2016 Globussoft. All rights reserved.
//

#import "MediaFireInit.h"

@implementation MediaFireInit{
    MFFolderAPI *floder;
}


-(void)mediaFireLogin{
    NSDictionary* sessionCallbacks =
    @{ONERROR : ^(NSDictionary* errorResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"[MFSDK OSX Demo] Error starting MediaFire session. - %@", errorResponse);
            
           // return NO;
            //[self showLoginError];
            
        });
    },ONLOAD  : ^(NSDictionary* loadResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [[NSNotificationCenter defaultCenter]postNotificationName:NSWorkspaceDidActivateApplicationNotification object:nil];
            

            
            
            
         //   NSLog(@"Loging in response  %@",loadResponse);
         [[NSUserDefaults standardUserDefaults]setObject:loadResponse[@"session_token"] forKey:@"MediaFireSessionToken"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
              //[self requestWelcomeText];
            

            
            
            
            
            
            
             [self requestFoldersChunk:1];

            
          //  return YES;
            
            
            
        });
    }};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [MediaFireSDK startSession:@"sukhmeethora@globussoft.in"
                      withPassword:@"Qwerty1234!@#$"//[[NSUserDefaults standardUserDefaults]objectForKey:@"UserPassword"]
                      andCallbacks:sessionCallbacks];
        
        // [self initiateMediaFire];
    });
    

}

#pragma mark-save file to media fire
-(void)initiateMediaFire:(NSString*)dirPath{
    //  [self requestWelcomeText];
    //  [self requestFoldersChunk:1];
    //
    //    NSOpenPanel* openPanel = [NSOpenPanel openPanel];
    //
    //    [openPanel setCanChooseFiles:TRUE];
    //    [openPanel setCanChooseDirectories:FALSE];
    //    [openPanel setAllowsMultipleSelection:FALSE];
    //    [openPanel setPrompt:@"Upload"];
    
    //    if ([openPanel runModal] == NSOKButton) {
    //        NSArray* files = [openPanel URLs];
    //        NSURL* selectFileURL = [files firstObject];
    [self uploadFileAtPath:dirPath];
    
    // }
    
}

#pragma mark-Fetching from the directory
-(void)fetching:(NSString*)path{
    
    //    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    //    for (int i = 0; i < (int)[directoryContent count]; i++)
    //    {
    //        NSLog(@"File %d: %@", (i + 1), [directoryContent objectAtIndex:i]);
    ////        NSLog(@"path of content %@",[localDirPath stringByAppendingPathComponent:[directoryContent objectAtIndex:i]]);
    
    
    [self initiateMediaFire:path];
    
    //}
    //[self initiateMediaFire:@"/Users/sumit/Documents/.EmployeeMonitor/10-02-2016/17-31-14.jpg"];
}

- (void)requestWelcomeText {
    NSDictionary* userCallbacks =
    @{ONERROR   : ^(NSDictionary* errorResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"[MFSDK OSX Demo] Error getting user info. - %@", errorResponse);
        });
    },ONLOAD    : ^(NSDictionary* loadResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
       //     NSLog(@"Response Welcome:::%@",loadResponse);
            [self requestFoldersChunk:1];
            
            NSDictionary* userInfo = loadResponse[@"user_info"];
            NSString* displayName = userInfo[@"display_name"];
            
            //[self.welcomeTextField setStringValue:[NSString stringWithFormat:@"Hello, %@!", displayName]];
        });
    }};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [MediaFireSDK.UserAPI getInfo:@{} callbacks:userCallbacks];
    });
}

//------------------------------------------------------------------------------
- (void)requestLinkForQuickkey:(NSString*)quickkey {
    NSDictionary* linkCallbacks =
    @{ONERROR   : ^(NSDictionary* errorResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"[MFSDK OSX Demo] Error getting link. - %@", errorResponse);
        });
    },ONLOAD    : ^(NSDictionary* loadResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray* linksList = loadResponse[@"links"];
            NSString* link = [linksList firstObject][@"normal_download"];
            
            //            [self.uploadLinkTextField setAllowsEditingTextAttributes:TRUE];
            //            [self.uploadLinkTextField setSelectable:TRUE];
            
            NSMutableAttributedString* attributedLink = [[NSMutableAttributedString alloc] initWithString:link];
            [attributedLink addAttribute:NSLinkAttributeName value:link range:NSMakeRange(0, link.length)];
            //            [self.uploadLinkTextField setAttributedStringValue:attributedLink];
            //
            //            [self.uploadLinkTextField selectText:self];
        });
    }};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [MediaFireSDK.FileAPI getLinks:@{@"quick_key" : quickkey, @"link_type" : @"normal_download"} callbacks:linkCallbacks];
    });
}

//------------------------------------------------------------------------------
- (void)requestFoldersChunk:(NSUInteger)chunk {
    
    floder=[[MFFolderAPI alloc]init];

    NSDictionary* contentCallbacks =
    @{ONERROR   : ^(NSDictionary* errorResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"[MFSDK OSX Demo] Error getting folder contents. - %@", errorResponse);
        });
    },ONLOAD    : ^(NSDictionary* loadResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary* folderContent = loadResponse[@"folder_content"];
            NSArray* folders = folderContent[@"folders"];
            
//    NSLog(@"Chunk Info:%@",loadResponse);
            
            
            for (int i=0; i<folders.count; i++) {
                
                if([[[folders objectAtIndex:i]objectForKey:@"name"]isEqual:@"EmpMonitor"]){
                    
                    
                    
                    
                    
                    
                     [floder create:[self createFolder:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"UserEmail"]]] callbacks:[self callBackCreateFolder]];
                    
                    
                }
            }
            
            
            if ([folders count] == 100) {
                [self requestFoldersChunk:chunk+1];
            } else {
                [self requestFilesChunk:1];
            }
        });
    }};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [MediaFireSDK.FolderAPI getContent:@{@"folder_key" : @"myfiles",
                                             @"content_type" : @"folders",
                                             @"chunk" : [NSNumber numberWithUnsignedInteger:chunk]}
                                 callbacks:contentCallbacks];
    });
}

//------------------------------------------------------------------------------
- (void)requestFilesChunk:(NSUInteger)chunk {
    NSDictionary* contentCallbacks =
    @{ONERROR   : ^(NSDictionary* errorResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"[MFSDK OSX Demo] Error getting folder contents. - %@", errorResponse);
        });
    },ONLOAD    : ^(NSDictionary* loadResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary* folderContent = loadResponse[@"folder_content"];
            NSArray* files = folderContent[@"files"];
            
            
            
            if ([files count] == 100) {
                [self requestFilesChunk:chunk+1];
            }
        });
    }};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [MediaFireSDK.FolderAPI getContent:@{@"folder_key" : @"myfiles",
                                             @"content_type" : @"files",
                                             @"chunk" : [NSNumber numberWithUnsignedInteger:chunk]}
                                 callbacks:contentCallbacks];
    });
}

//- (void)showLoginError {
//    NSAlert *alert = [[NSAlert alloc] init];
//    [alert addButtonWithTitle:@"OK"];
//    [alert setMessageText:@"MediaFire Login Error"];
//    [alert setInformativeText:@"Error logging in to your MediaFire account. Please ensure your email address and password are correct."];
//    [alert setAlertStyle:NSWarningAlertStyle];
//    
//    [alert runModal];
//}
//
- (void)uploadFileAtPath:(NSString*)path {
    //    [self.uploadLinkTextField setHidden:FALSE];
    //    [self.uploadNameTextField setHidden:FALSE];
    //    [self.uploadProgressIndicator setHidden:FALSE];
    //    [self.uploadStatusTextField setHidden:FALSE];
    //
    
    
   // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    
    
    [NSThread detachNewThreadSelector:@selector(uploadToCloud:) toTarget:self withObject:path];
    
            //});
}

-(void)uploadToCloud:(NSString*)path{
    
    
    MFUploadTransaction* upt = [[MFUploadTransaction alloc] initWithFilePath:path];
    //   upt.folderkey=@"EMPMonitor";
    
    
    [upt startWithCallbacks:[self getUploadCallbacks]];

}

//--------------------------------create Folder in Media Fire-----------------
#pragma mark-Creating folder in Media Fire
-(NSDictionary*)createFolder:(NSString*)folderName{
    
    return @{@"session_token":[[NSUserDefaults standardUserDefaults]objectForKey:@"MediaFireSessionToken"],
             @"foldername":folderName
            };
    
}

-(NSDictionary*)callBackCreateFolder{
    NSDictionary* createFolderCallbacks =
    @{ONERROR : ^(NSDictionary* errorResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            NSLog(@"Error while crreating folder %@",errorResponse);
            
                  });
        
    },
      
      ONLOAD : ^(NSDictionary* loadResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
           // NSLog(@"Messsage while crreating folder %@",loadResponse);
            
            
          
        });
    }};
    
    return createFolderCallbacks;
}

//------------------------------------------------------------------------------
- (NSDictionary*)getUploadCallbacks {
    NSDictionary* uploadCallbacks =
    @{ONERROR : ^(NSDictionary* errorResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary* response  = errorResponse[@"response"];
            NSDictionary* fileInfo  = errorResponse[@"fileInfo"];
            
            NSLog(@"[MFSDK OSX Demo] Upload failure. - %@", response);
            
            //            [self.uploadNameTextField setStringValue:[NSString stringWithFormat:@"Uploading %@", fileInfo[UFILENAME]]];
            //            [self.uploadStatusTextField setStringValue:@"Upload failed!"];
        });
        
    },ONUPDATE : ^(NSDictionary* updateResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary* response  = updateResponse[@"response"];
            NSDictionary* fileInfo  = updateResponse[@"fileInfo"];
            // NSString* event         = response[UEVENT];
            
          //  NSLog(@"response Update::%@",updateResponse);
          
            [self updateProgressFromFileInfo:fileInfo];
            
            // [self.uploadNameTextField setStringValue:[NSString stringWithFormat:@"Uploading %@", fileInfo[UFILENAME]]];
            
                             });
    },ONLOAD : ^(NSDictionary* loadResponse) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary* response  = loadResponse[@"response"];
            NSDictionary* fileInfo  = loadResponse[@"fileInfo"];
            NSDictionary* doUpload  = response[@"doupload"];
            
            
            NSLog(@"-------------->Upload Sucess<--------------");
           // NSLog(@"%@",loadResponse);
            
            //if success delete from local
            NSError *error;
            [[NSFileManager defaultManager] removeItemAtPath:fileInfo[@"path"] error:&error];
            
            
            if (doUpload[@"quickkey"] != nil) {
                [self requestLinkForQuickkey:doUpload[@"quickkey"]];
            } else if (response[@"duplicate_quickkey"] != nil) {
                [self requestLinkForQuickkey:response[@"duplicate_quickkey"]];
            }
        });
    }};
    
    return uploadCallbacks;
}


-(void)getAllDetail{
    
    [[NSUserDefaults standardUserDefaults]objectForKey:@"mathm"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
}

//----------------------------------------------------------------------------
- (void)updateProgressFromFileInfo:(NSDictionary*)fileInfo {
    NSUInteger lastUnit = [fileInfo[@"lastunit"] integerValue];
    NSUInteger unitCount  = [fileInfo[@"unitcount"] integerValue];
    
    if (lastUnit == 0 || unitCount == 0) {
        //        [self.uploadProgressIndicator setIndeterminate:TRUE];
        //        [self.uploadProgressIndicator startAnimation:self];
    } else {
        //        [self.uploadProgressIndicator setIndeterminate:FALSE];
        //        [self.uploadProgressIndicator setDoubleValue:(double)lastUnit/unitCount];
    }
}
-(void)syncAllDatas:(NSString*)localDirectory{
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:localDirectory error:NULL];
    for (int count = 0; count < (int)[directoryContent count]; count++)
    {
        
        
         NSArray *folderContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[localDirectory stringByAppendingPathComponent:[directoryContent objectAtIndex:count]] error:NULL];
        
        
            
         //   NSLog(@"File %d: %@", (i + 1), [folderContents objectAtIndex:i]);
//            dispatch_queue_t myQueue = dispatch_queue_create("unique_queue_name", NULL);
//        
//                   dispatch_async(myQueue, ^{
                //stuffs to do in background thread
                
              
                       for (int i=0; i<folderContents.count; i++) {
                           [self uploadFileAtPath:[folderContents objectAtIndex:i]];
                       }

//                dispatch_async(dispatch_get_main_queue(), ^{
//                   
//                    
//                    
//                    
//                    //stuffs to do in foreground thread, mostly UI updates
//                });
           // });
            
            
//        }
        
        
        
    }
    
    
}

@end
