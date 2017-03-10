//
//  MFCredentialsDelegate.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 4/3/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MFCredentialsDelegate <NSObject>

@required
//------------------------------------------------------------------------------
+ (BOOL)purgeCredentials;

//------------------------------------------------------------------------------
+ (NSDictionary*)getCredentials;

//------------------------------------------------------------------------------
+ (BOOL)isValid;

//------------------------------------------------------------------------------
+ (BOOL)validate;

//------------------------------------------------------------------------------
+ (BOOL)setMediaFire:(NSString*)email withPassword:(NSString*)password;

//------------------------------------------------------------------------------
+ (BOOL)setFacebook:(NSString*)token;

//------------------------------------------------------------------------------
+ (BOOL)setTwitter:(NSString*)token withSecret:(NSString*)secret;


@end
