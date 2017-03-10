//
//  NSString+StringURL.h
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/31/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringURL)

/**
 @brief Generates a url-encoded string from self.
 */
-(NSString*) urlEncode;

@end
