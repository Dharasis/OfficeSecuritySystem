//
//  MediaFireSDK.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 4/15/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MediaFireSDK.h"
#import "MFConfig.h"
#import "MFRequestManager.h"
#import "MFSerialRequestManager.h"
#import "MFParallelRequestManager.h"
#import "MFCredentials.h"
#import "NSDictionary+MapObject.h"

static id instance = nil;

@interface MediaFireSDK()

@property(strong,nonatomic,getter=SessionAPI)MFSessionAPI*  session;
@property(strong,nonatomic,getter=ActionTokenAPI)MFActionTokenAPI*  token;
@property(strong,nonatomic,getter=ContactAPI)MFContactAPI*  contact;
@property(strong,nonatomic,getter=DeviceAPI)MFDeviceAPI*    device;
@property(strong,nonatomic,getter=FileAPI)MFFileAPI*        file;
@property(strong,nonatomic,getter=FolderAPI)MFFolderAPI*    folder;
@property(strong,nonatomic,getter=SystemAPI)MFSystemAPI*    system;
@property(strong,nonatomic,getter=UploadAPI)MFUploadAPI*    upload;
@property(strong,nonatomic,getter=UserAPI)MFUserAPI*        user;
@property(strong,nonatomic,getter=MediaAPI)MFMediaAPI*      media;

@end

@implementation MediaFireSDK

//------------------------------------------------------------------------------
- (id) init {
    return [self initWithConfig:nil];
}

//------------------------------------------------------------------------------
- (id) initWithConfig:(NSDictionary*)config {
    // sanity check
    if (instance != nil) {
        return instance;
    }
    if (config == nil) {
        return nil;
    }
    self = [super init];

    return self;
}

//------------------------------------------------------------------------------
+ (bool)createWithConfig:(NSDictionary*)config {
    // sanity check
    if (instance != nil) {
        return false;
    }
    if (config == nil) {
        return false;
    }
    bool firstRun = false;
    @synchronized(self){
        if (instance == nil) {
            firstRun = true;
            instance = [[self alloc] initWithConfig:config];
        }
    }
    if (firstRun) {
        NSMutableDictionary* defaults = [[NSMutableDictionary alloc] init];
        if (config[MFCONF_SRM_DELEGATE] == nil) {
            defaults[MFCONF_SRM_DELEGATE] = [MFSerialRequestManager class];
        }
        if (config[MFCONF_PRM_DELEGATE] == nil) {
            defaults[MFCONF_PRM_DELEGATE] = [MFParallelRequestManager class];
        }
        if (config[MFCONF_CREDS_DELEGATE] == nil) {
            defaults[MFCONF_CREDS_DELEGATE] = [MFCredentials class];
        }
        config = [config merge:defaults];
        [MFConfig createWithConfig:config];
    }
    [MFRequestManager setSessionTokenAPI:self.SessionAPI];
    [MFRequestManager setActionTokenAPI:self.ActionTokenAPI forType:@"image"];
    [MFRequestManager setActionTokenAPI:self.ActionTokenAPI forType:@"upload"];
    return firstRun;
}

+ (instancetype) getInstance{
    return instance;
}

//------------------------------------------------------------------------------
- (void)startSession:(NSString*)email withPassword:(NSString*)password andCallbacks:(NSDictionary*)callbacks {
    [MediaFireSDK startSession:email withPassword:password andCallbacks:callbacks];
}

+ (void)startSession:(NSString*)email withPassword:(NSString*)password andCallbacks:(NSDictionary*)callbacks {
    [MFRequestManager startSession:email withPassword:password andCallbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)startSessionWithCallbacks:(NSDictionary*)callbacks {
    [MediaFireSDK startSessionWithCallbacks:callbacks];
}

+ (void)startSessionWithCallbacks:(NSDictionary*)callbacks {
    [MFRequestManager startSessionWithCallbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)startFacebookSession:(NSString*)authToken withCallbacks:(NSDictionary*)callbacks {
    [MediaFireSDK startFacebookSession:authToken withCallbacks:callbacks];
}

+ (void)startFacebookSession:(NSString*)authToken withCallbacks:(NSDictionary*)callbacks {
    [MFRequestManager startFacebookSession:authToken withCallbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)endSession {
    [MediaFireSDK endSession];
}

+ (void)endSession {
    [MFRequestManager endSession];
}

//------------------------------------------------------------------------------
+ (BOOL)hasSession {
    return [MFRequestManager hasSession];
}

//------------------------------------------------------------------------------
- (void)destroy {
    [MediaFireSDK destroy];
}

+ (void)destroy {
    [MFRequestManager destroy];
    [MFConfig destroy];
    @synchronized(self) {
        instance = nil;
    }
}

//------------------------------------------------------------------------------
- (MFSessionAPI*)SessionAPI {
    if (_session == nil) {
        _session = [[MFSessionAPI alloc] init];
    }
    return _session;
}

+ (MFSessionAPI*)SessionAPI {
    return [instance SessionAPI];
}

//------------------------------------------------------------------------------
- (MFActionTokenAPI*)ActionTokenAPI {
    if (_token == nil) {
        _token = [[MFActionTokenAPI alloc] init];
    }
    return _token;
}

+ (MFActionTokenAPI*)ActionTokenAPI {
    return [instance ActionTokenAPI];
}

//------------------------------------------------------------------------------
- (MFContactAPI*)ContactAPI {
    if (_contact == nil) {
        _contact = [[MFContactAPI alloc] init];
    }
    return _contact;
}

+ (MFContactAPI*)ContactAPI {
    return [instance ContactAPI];
}

//------------------------------------------------------------------------------
- (MFDeviceAPI*)DeviceAPI {
    if (_device == nil) {
        _device = [[MFDeviceAPI alloc] init];
    }
    return _device;
}

+ (MFDeviceAPI*)DeviceAPI {
    return [instance DeviceAPI];
}

//------------------------------------------------------------------------------
- (MFFileAPI*)FileAPI {
    if (_file == nil) {
        _file = [[MFFileAPI alloc] init];
    }
    return _file;
}

+ (MFFileAPI*)FileAPI {
    return [instance FileAPI];
}

//------------------------------------------------------------------------------
- (MFFolderAPI*)FolderAPI {
    if (_folder == nil) {
        _folder = [[MFFolderAPI alloc] init];
    }
    return _folder;
}

+ (MFFolderAPI*)FolderAPI {
    return [instance FolderAPI];
}

//------------------------------------------------------------------------------
- (MFSystemAPI*)SystemAPI {
    if (_system == nil) {
        _system = [[MFSystemAPI alloc] init];
    }
    return _system;
}

+ (MFSystemAPI*)SystemAPI {
    return [instance SystemAPI];
}

//------------------------------------------------------------------------------
- (MFUploadAPI*)UploadAPI {
    if (_upload == nil) {
        _upload= [[MFUploadAPI alloc] init];
    }
    return _upload;
}

+ (MFUploadAPI*)UploadAPI {
    return [instance UploadAPI];
}

//------------------------------------------------------------------------------
- (MFUserAPI*)UserAPI {
    if (_user == nil) {
        _user = [[MFUserAPI alloc] init];
    }
    return _user;
}

+ (MFUserAPI*)UserAPI {
    return [instance UserAPI];
}

//------------------------------------------------------------------------------
- (MFMediaAPI*)MediaAPI {
    if (_media == nil) {
        _media = [[MFMediaAPI alloc] init];
    }
    return _media;
}

+ (MFMediaAPI*)MediaAPI {
    return [instance MediaAPI];
}

@end
