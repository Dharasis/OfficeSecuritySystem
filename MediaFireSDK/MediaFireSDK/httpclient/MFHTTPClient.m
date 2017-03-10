//
//  MFHTTPClient.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 5/30/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFHTTPClient.h"
#import "NSDictionary+Callbacks.h"
#import "MFHTTPData.h"
#import "MFHTTPOptions.h"
#import "NSDictionary+MapObject.h"
#import "MFURLRequestConfig.h"
#import "MFErrorLog.h"
#import "MFConfig.h"

@implementation MFHTTPClient

//------------------------------------------------------------------------------
- (id)init {
    return [self initWithConfig:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

//------------------------------------------------------------------------------
- (id)initWithConfig:(NSURLSessionConfiguration*)config {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    _appRequestData = [[NSMutableDictionary alloc] init];
    _opLock = [[NSLock alloc] init];
    _counter = 1;
    _defaultMethod = @"POST";
    return self;
}

//------------------------------------------------------------------------------
- (NSMutableURLRequest*)constructURLRequestFromConfig:(MFURLRequestConfig*)config {
    NSMutableURLRequest* req = [[NSMutableURLRequest alloc] init];
    req.URL = config.url;

    for (NSString* headerName in config.headers) {
        [req setValue:config.headers[headerName] forHTTPHeaderField:headerName];
    }

    NSString* method = config.method;
    if (method == nil) {
        method = self.defaultMethod;
    }
    [req setHTTPMethod:method];

    if ([method isEqualToString:@"POST"] && (config.body != nil)) {
        [req setHTTPBody: config.body];
    }
    return req;
}

//------------------------------------------------------------------------------
- (void)beginTask:(NSURLSessionTask*)task withConfig:(MFURLRequestConfig*)config {
    if (task == nil) {
        mflog(@"Unable to begin nil task.");
        config.httpFail(nil, 0, nil);
        return;
    }
    MFHTTPData* data = [[MFHTTPData alloc]init];
    data.task = task;
    data.callbacks =
    @{ONLOAD:config.httpSuccess,ONERROR:config.httpFail, ONPROGRESS:config.httpProgress, @"httpClientRef":config.httpReference};
    
    config.httpSuccess = nil;
    config.httpFail = nil;
    config.httpProgress = nil;
    config.httpReference = nil;
    
    NSString* key = nil;
    if (config.desc.length) {
        key = config.desc;
    } else {
        [self.opLock lock];
        key = [NSString stringWithFormat:@"%lli",self.counter];
        if (self.counter > (INT64_MAX - 100)) {
            self.counter = 1;
        }
        self.counter++;
        [self.opLock unlock];
    }
    self.appRequestData[key] = data;
    data.task.taskDescription = key;
    data.localPathForDownload = config.localPathForDownload;
    data.localPathForUpload = config.localPathForUpload;
    [data.task resume];
    [MFConfig showNetworkIndicator];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"
//------------------------------------------------------------------------------
- (id)constructTaskWithRequest:(NSMutableURLRequest*)request config:(MFURLRequestConfig*)config{
    return [self.session dataTaskWithRequest:request];
}
#pragma clang diagnostic pop

//------------------------------------------------------------------------------
- (void)addRequest:(MFURLRequestConfig*)config {
    if (config == nil) {
        return;
    }

    NSMutableURLRequest* req = [self constructURLRequestFromConfig:config];
    if (req == nil) {
        mflog(@"request was nil");
        config.httpFail(nil, 0, nil); 
        return;
    }
    [self beginTask:[self constructTaskWithRequest:req config:config] withConfig:config];
}

- (void)destroy {
    [self.session invalidateAndCancel];
    self.session = nil;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"
//------------------------------------------------------------------------------
- (void)URLSession:(NSURLSession*)session task:(NSURLSessionTask*)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    // prevent div by 0
    if (bytesSent == 0 ) {
        return;
    }
    MFHTTPData* requestData = [self getAppRequestDataForTask:task];
    if (requestData == nil) {
        return;
    }
    MFProgressCallback cb = requestData.callbacks.onprogress;
    if (cb == nil) {
        return;
    }
    double progress = (double)(totalBytesExpectedToSend/totalBytesSent);
    cb(progress);
}

//------------------------------------------------------------------------------
- (void)URLSession:(NSURLSession*)session task:(NSURLSessionTask*)task willPerformHTTPRedirection:(NSHTTPURLResponse*)response newRequest:(NSURLRequest*)request completionHandler:(void (^)(NSURLRequest*))completionHandler {
    mflog(@"MFHTTPClient willRedirect");
    completionHandler(request);
}
#pragma clang diagnostic pop

//------------------------------------------------------------------------------
- (MFHTTPData*)getAppRequestDataForTask:(NSURLSessionTask*)task {
    // sanity check
    if ([task.taskDescription isEqualToString:@""]) {
        mflog(@"INVALID REQUEST ID");
        return nil;
    }
    NSString* key = task.taskDescription;
    [self.opLock lock];
    if (self.appRequestData[key] == nil) {
        [self.opLock unlock];
        [self requestNotFound:key];
        return nil;
    }
    if (![self.appRequestData[key] isKindOfClass:[MFHTTPData class]]) {
        [self.opLock unlock];
        mflog(@"INVALID DATA CONTAINER %@ (%@)", key, [self.appRequestData[key] class]);
        return nil;
    }
    MFHTTPData* data = self.appRequestData[key];
    [self.opLock unlock];
    return data;
}

- (void)requestNotFound:(NSString*)description {
    mflog(@"ERROR ON KEY %@", description);
}

//------------------------------------------------------------------------------
- (MFHTTPData*)removeAppRequestDataForTask:(NSURLSessionTask*)task {
    // sanity check
    if ([task.taskDescription isEqualToString:@""]) {
        mflog(@"INVALID REQUEST ID");
        return nil;
    }
    NSString* key = task.taskDescription;
    [self.opLock lock];
    if (self.appRequestData[key] == nil) {
        [self.opLock unlock];
        [self requestNotFound:key];
        return nil;
    }
    if (![self.appRequestData[key] isKindOfClass:[MFHTTPData class]]) {
        [self.opLock unlock];
        mflog(@"INVALID DATA CONTAINER %@", key);
        return nil;
    }
    MFHTTPData* data = self.appRequestData[key];
    [self.appRequestData removeObjectForKey:key];
    [self.opLock unlock];
    return data;
}


@end
