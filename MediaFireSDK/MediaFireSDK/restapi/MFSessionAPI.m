//
//  MFSessionAPI.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/10/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFSessionAPI.h"
#import "MFAPIURLRequestConfig.h"
#import "MFCredentials.h"
#import "NSDictionary+Callbacks.h"
#import "NSDictionary+MapObject.h"
#import "NSDictionary+JSONExtender.h"
#import "NSString+JSONExtender.h"
#import "NSString+StringURL.h"
#import "MFRequestHandler.h"
#import "MFErrorMessage.h"
#import "MFREST.h"
#import "MFHTTP.h"
#import "MFConfig.h"
#import "MFHash.h"

@implementation MFSessionAPI

//------------------------------------------------------------------------------
- (id)init {
    self = [self initWithVersion:[MFConfig defaultAPIVersionForModule:@"MFSessionAPI"]];
    if (self == nil) {
        return nil;
    }
    return self;
}

//------------------------------------------------------------------------------
- (id)initWithVersion:(NSString*)version {
    self = [super initWithPath:@"user" version:version];
    if (self == nil) {
        return nil;
    }
    return self;
}


//------------------------------------------------------------------------------
- (void)getSessionToken:(NSDictionary*)credentials callbacks:(NSDictionary*)callbacks {
    [self getSessionToken:@{} query:credentials callbacks:callbacks];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"
//------------------------------------------------------------------------------
- (void)getSessionToken:(NSDictionary*)options query:(NSDictionary*)credentials callbacks:(NSDictionary*)callbacks {
    // bail out if credentials are empty
    if (!credentials) {
        if (callbacks.onerror) {
            callbacks.onerror(erm(nullField:@"new token callbacks"));
        }
        return;
    }
    
    // construct the request
    MFAPIURLRequestConfig* config = [[MFAPIURLRequestConfig alloc] init];
    config.location = @"get_session_token.php";
    
    config.method = @"POST";
    config.queryDict = [MFSessionAPI generateAuthenticationDictionaryFromCredentials:credentials version:@"2"];
    config.secure = true;
    
    NSDictionary* customizedCallbacks = @{ONERROR:callbacks.onerror,
                                           ONLOAD:^(NSDictionary* response) {
        // sanity check
        if (![MFSessionAPI validateTokenResponse:response withVersion:@"2"]) {
            callbacks.onerror(erm(nullField:@"new token response"));
            return;
        }
        // strip out outer response
        NSMutableDictionary* innerResponse = [response mutableCopy];
        // check for valid content in response
        if ( innerResponse[@"session_token"] == nil || [innerResponse[@"session_token"] isEqualToString:@""]) {
            callbacks.onerror(innerResponse);
            return;
        }
        // if JSON parser interprets the key as a string, we need to convert it to a number.
        id secret = innerResponse[@"secret_key"];
        if ( [secret isKindOfClass:[NSString class]] ) {
            NSUInteger secretKey = (NSUInteger)[secret integerValue];
            secret = [NSNumber numberWithUnsignedInteger:secretKey];
            innerResponse[@"secret_key"] = secret;
        }
        callbacks.onload(innerResponse);
    }};
    
    // start the request
    [self createRequest:config callbacks:customizedCallbacks];
}
#pragma clang diagnostic pop

//------------------------------------------------------------------------------
+ (BOOL)validateTokenResponse:(NSDictionary*)response withVersion:(NSString*)version {
    // sanity check
    if (!response) {
        erm(nullField:@"response");
        return false;
    }
    
    // validation
    if ( ! [[response[@"result"] capitalizedString] isEqualToString:@"Success"] ) {
        erm(badResponse:response);
        return false;
    }
    if ( response[@"session_token"] == nil ) {
        erm(nullField:@"session_token");
        return false;
    }
    
    // session token 2.0 requires the additional fields.
    if ([version integerValue] >= 2) {
        if ( response[@"time"] == nil ) {
            erm(nullField:@"time");
            return false;
        }
        id secret = response[@"secret_key"];
        if ( secret == nil ) {
            erm(nullField:@"secret_key");
            return false;
        }
    }
    return true;
}

//------------------------------------------------------------------------------
+ (NSString*)generateAuthenticationQueryStringFromCredentials:(NSDictionary*)credentials version:(NSString*)version {
    return [[self generateAuthenticationDictionaryFromCredentials:credentials version:version] mapToUrlString];
}

//------------------------------------------------------------------------------
+ (NSDictionary*)generateAuthenticationDictionaryFromCredentials:(NSDictionary*)credentials version:(NSString*)version {
    NSString*               signatureBase   = nil;
    NSString*               authType        = credentials[@"type"];
    NSMutableDictionary*    params          = [[NSMutableDictionary alloc] initWithCapacity:4];
    if ( [authType isEqualToString:MFCRD_TYPE_EKEY] ) {
        // use MediaFire credentials
        if (credentials[MFCRD_MF_EKEY] == nil || credentials[MFCRD_MF_PASS] == nil) {
            erm(nullField:@"credentials for ekey signature");
            return nil;
        }
        NSString* ekey = credentials[MFCRD_MF_EKEY];
        NSString* password = credentials[MFCRD_MF_PASS];
        signatureBase = [NSString stringWithFormat:@"%@%@", ekey, password];
        params[@"ekey"]    = ekey;
        params[@"password"] = password;
    } else if ( [authType isEqualToString:MFCRD_TYPE_MF] ) {
        // use MediaFire credentials
        if (credentials[MFCRD_MF_EMAIL] == nil || credentials[MFCRD_MF_PASS] == nil) {
            erm(nullField:@"credentials for mf signature");
            return nil;
        }
        NSString* email = credentials[MFCRD_MF_EMAIL];
        NSString* password = credentials[MFCRD_MF_PASS];
        signatureBase = [NSString stringWithFormat:@"%@%@", email, password];
        params[@"email"]    = email;
        params[@"password"] = password;
    } else if ([authType isEqualToString:MFCRD_TYPE_FB]){
        // use Facebook credentials
        signatureBase = credentials[MFCRD_FB_TOKEN];
        params[@"fb_access_token"] = signatureBase;
    } else {
        erm(invalidField:@"authentication type");
        return nil;
    }
    NSString* appId = [[MFConfig instance] appId];
    if (appId == nil) {
        erm(nullField:@"application id");
        return nil;
    }
    NSString* apiKey = [[MFConfig instance] apiKey];
    if (apiKey == nil) {
        apiKey = @"";
    }
    NSString * signature = [MFHash sha1Hex:[signatureBase stringByAppendingFormat:@"%@%@", appId, apiKey]];
    params[@"application_id"]   = appId;
    params[@"signature"]        = signature;
    params[@"token_version"]    = version;
    params[@"response_format"]  = @"json";
    
    return params;
}


@end
