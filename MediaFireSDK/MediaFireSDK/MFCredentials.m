//
//  MFCredentials.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 4/3/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFCredentials.h"

@implementation MFCredentials

NSString* const MFCRD_MF_EMAIL    = @"email";
NSString* const MFCRD_MF_EKEY     = @"ekey";
NSString* const MFCRD_MF_PASS     = @"password";
NSString* const MFCRD_FB_TOKEN    = @"fbtoken";
NSString* const MFCRD_TW_SECRET   = @"twsecret";
NSString* const MFCRD_TW_TOKEN    = @"twtoken";
NSString* const MFCRD_TYPE_FB     = @"facebook";
NSString* const MFCRD_TYPE_MF     = @"mediafire";
NSString* const MFCRD_TYPE_TW     = @"twitter";
NSString* const MFCRD_TYPE_EKEY   = @"mediafire_ekey";

static NSDictionary* tmpCreds;
static bool validCreds = false;

//------------------------------------------------------------------------------
+ (BOOL)purgeCredentials {
    validCreds = false;
    tmpCreds = nil;
    return true;
}

//------------------------------------------------------------------------------
+ (NSDictionary*)getCredentials {
    return tmpCreds;
}

//------------------------------------------------------------------------------
+ (BOOL)isValid {
    return validCreds;
}

//------------------------------------------------------------------------------
+ (BOOL)validate {
    validCreds = true;
    return true;
}

//------------------------------------------------------------------------------
+ (BOOL)setMediaFire:(NSString*)email withPassword:(NSString*)password {
    // sanity check
    if ( email == nil ) {
        return false;
    }
    if ( password == nil ) {
        password = @"";
    }
    // clear all credentials before setting a new value.
    [self purgeCredentials];
    tmpCreds = @{@"type" : MFCRD_TYPE_MF, MFCRD_MF_EMAIL : email, MFCRD_MF_PASS: password};
    return true;
}

//------------------------------------------------------------------------------
+ (BOOL)convertToEKey:(NSString*)ekey {
    if ( ekey == nil ) {
        return false;
    }
    if (![tmpCreds[@"type"] isEqualToString:MFCRD_TYPE_MF]) {
        return false;
    }
    tmpCreds = @{@"type" : MFCRD_TYPE_EKEY, MFCRD_MF_EKEY : ekey, MFCRD_MF_PASS: tmpCreds[MFCRD_MF_PASS]};
    return true;
}

//------------------------------------------------------------------------------
+ (BOOL)setFacebook:(NSString*)token {
    // sanity check
    if ( token == nil ) {
        return false;
    }
    // clear all credentials before setting a new value.
    [self purgeCredentials];
    tmpCreds = @{@"type" : MFCRD_TYPE_FB, MFCRD_FB_TOKEN : token};
    return true;
}

//------------------------------------------------------------------------------
+ (BOOL)setTwitter:(NSString*)token withSecret:(NSString*)secret {
    // sanity check
    if ((token == nil) || (secret == nil)) {
        return false;
    }
    // clear all credentials before setting a new value.
    [self purgeCredentials];
    tmpCreds = @{@"type" : MFCRD_TYPE_TW, MFCRD_TW_TOKEN : token, MFCRD_TW_SECRET : secret};
    return true;
}

@end
