//
//  MFMediaAPI.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/2/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFMediaAPI.h"
#import "NSString+JSONExtender.h"
#import "MFErrorMessage.h"
#import "MFErrorLog.h"
#import "NSString+StringURL.h"
#import "MFRequestManager.h"
#import "NSDictionary+Callbacks.h"
#import "NSDictionary+MapObject.h"
#import "MFAPIURLRequestConfig.h"
#import "MFAPI.h"
#import "MFHTTPOptions.h"

@implementation MFMediaAPI

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"
//------------------------------------------------------------------------------
+ (NSString*)generateConversionServerURL:(NSString*)baseUrlString withHash:(NSString*)hash withParameters:(NSDictionary*)params {
    // Sanity checks
    if ( baseUrlString == nil ) {
        mflog(@"[generateConversionServerURL] baseUrlString is nil.");
        return nil;
    }
    if ( params == nil ) {
        mflog(@"[generateConversionServerURL] params is nil.");
        return nil;
    }
    if ( hash == nil || [hash length] < 4) {
        mflog(@"[generateConversionServerURL] hash is nil or fewer than 4 digits.");
        return nil;
    }
    
    __block NSString*     paramsUrlString   = [[NSString alloc] initWithFormat:@"?%@",[hash substringToIndex:4]];
    NSMutableDictionary*  newParams         = [NSMutableDictionary dictionaryWithCapacity:[params count]];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        if ( [obj isKindOfClass:[NSString class]] ) {
            newParams[key] = [obj urlEncode];
        } else {
            newParams[key] = obj;
        }
    }];
    
    NSString* resultUrlString = [NSString stringWithFormat:@"%@%@", baseUrlString, paramsUrlString];
    return resultUrlString;
}
#pragma clang diagnostic pop

//------------------------------------------------------------------------------
- (NSString*)getPreviewURL:(NSDictionary*)parameters withHash:(NSString*)hash {
    return [MFMediaAPI generateConversionServerURL:@"/conversion_server.php"
                                     withHash:hash
                               withParameters:parameters];
}

//------------------------------------------------------------------------------
- (void)getPreviewBinary:(NSDictionary*)parameters hash:(NSString*)hash callbacks:(NSDictionary*)callbacks {
    [self getPreviewBinary:@{} query:parameters hash:hash callbacks:callbacks];
}

- (void)getPreviewBinary:(NSDictionary*)options query:(NSDictionary*)parameters hash:(NSString*)hash callbacks:(NSDictionary*)callbacks {
    [self createRequest:[options merge:@{HMETHOD : @"GET",
                                         HURL : [self getPreviewURL:parameters withHash:hash],
                                         HTOKEN : HTKT_PARA,
                                         HPARALLEL : HPTT_IMAGE}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)getPreviewBinaryCachedPath:(NSDictionary*)parameters hash:(NSString*)hash callbacks:(NSDictionary*)callbacks  {
    [self getPreviewBinaryCachedPath:@{} query:parameters hash:hash callbacks:callbacks];
}

- (void)getPreviewBinaryCachedPath:(NSDictionary*)options query:(NSDictionary*)parameters hash:(NSString*)hash callbacks:(NSDictionary*)callbacks {
    if (hash == nil || [hash isEqualToString:@""] || [hash length] < 4) {
        callbacks.onerror(erm(nullField:@"hash"));
        return;
    }
    
    // Paths
    NSString* cachedDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    if (cachedDirectoryPath == nil || [cachedDirectoryPath isEqualToString:@""]) {
        callbacks.onerror(erm(nullField:@"cachedDirectoryPath"));
        return;
    }
    
    NSString* cachedImagePath = [cachedDirectoryPath stringByAppendingPathComponent:
                                 [NSString stringWithFormat:@"images/%@/%@", parameters[@"size_id"], hash]];
    
    NSString* cachedImageSizePath = [cachedImagePath stringByDeletingLastPathComponent];
    
    // Check and create directory(ies)
    BOOL isDirectory = FALSE;
    BOOL isExisting = [[NSFileManager defaultManager] fileExistsAtPath:cachedImageSizePath isDirectory:&isDirectory];
    
    if (isExisting && !isDirectory) {
        mflog(@"Directory at %@ exists as a file.", cachedImageSizePath);
        callbacks.onerror(erm(invalidField:@"cachedImageSizePath"));
        return;
    }
    
    if (!isExisting) {
        NSError* error;
        BOOL isCreated = [[NSFileManager defaultManager] createDirectoryAtPath:cachedImageSizePath withIntermediateDirectories:TRUE attributes:nil error:&error];
        
        if (!isCreated || error != nil) {
            mflog(@"Failed to create directory at: %@. Error - %@", cachedImageSizePath, error.userInfo);
            callbacks.onerror(erm(invalidField:@"cachedImageSizePath"));
        }
    }
    
    NSString* url = [self getPreviewURL:parameters withHash:hash];
    
    [self createRequest:[options merge:@{HMETHOD : @"GET",
                                         HLOCALPATH: cachedImagePath,
                                         HURL : url,
                                         HTOKEN: HTKT_PARA,
                                         HPARALLEL : HPTT_IMAGE,
                                         HTIMEOUT : @5000}]
                  query:parameters
              callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)createRequest:(NSDictionary*)options query:(NSDictionary*)params callbacks:(NSDictionary*)cb {
    if (cb == nil) {
        erm(NullCallback);
        return;
    }
    if (options == nil) {
        cb.onerror([MFErrorMessage nullField:@"options"]);
        return;
    }
    MFAPIURLRequestConfig* config = [[MFAPIURLRequestConfig alloc] initWithOptions:options query:params];
    config.location = options[@"url"];
    
    [MFRequestManager createRequest:config callbacks:cb];
}

//------------------------------------------------------------------------------
- (void)directDownload:(NSURL*)url callbacks:(NSDictionary*)callbacks {
    [self directDownload:@{} url:url callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)directDownload:(NSDictionary*)options url:(NSURL*)url callbacks:(NSDictionary*)callbacks {
    if (url == nil) {
        callbacks.onerror(erm(nullURL));
    }
    
    NSString* localPath = [NSTemporaryDirectory() stringByAppendingPathComponent:url.lastPathComponent];
    if (localPath == nil) {
        localPath = @"";
    }
    
    [self createRequest:[options merge:@{HMETHOD : @"GET",
                                         HTOKEN : HTKT_NONE,
                                         HLOCALPATH : localPath,
                                         HHOST : url.host,
                                         HURL : url.path}]
                  query:@{}
              callbacks:callbacks];
    
}

//------------------------------------------------------------------------------
- (void)directDownloadToMemory:(NSURL*)url callbacks:(NSDictionary*)callbacks {
    [self directDownloadToMemory:@{} url:url callbacks:callbacks];
}

//------------------------------------------------------------------------------
- (void)directDownloadToMemory:(NSDictionary*)options url:(NSURL*)url callbacks:(NSDictionary*)callbacks {
    if (url == nil) {
        callbacks.onerror(erm(nullURL));
    }
    
    NSString* pathWithQuery = @"";
    
    if (url.query.length) {
        pathWithQuery = [NSString stringWithFormat:@"%@?%@", url.path, url.query];
    } else {
        pathWithQuery = url.path;
    }
    if (pathWithQuery == nil) {
        pathWithQuery = @"";
    }
    
    [self createRequest:[options merge:@{HMETHOD : @"GET",
                                         HTOKEN : HTKT_NONE,
                                         HHOST : url.host,
                                         HURL: pathWithQuery}]
                  query:@{}
              callbacks:callbacks];
}

@end
