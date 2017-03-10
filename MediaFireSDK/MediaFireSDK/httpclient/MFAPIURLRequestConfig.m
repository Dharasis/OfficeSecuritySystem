//
//  MFAPIURLRequestConfig.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 7/3/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFAPIURLRequestConfig.h"
#import "MFErrorMessage.h"
#import "MFREST.h"
#import "MFHTTPOptions.h"
#import "MFConfig.h"

static NSString* DEFAULT_METHOD = @"POST";

@implementation MFAPIURLRequestConfig

- (id)init {
    return [self initWithOptions:nil query:nil];
}

//------------------------------------------------------------------------------
- (id)initWithOptions:(NSDictionary *)options query:(NSDictionary *)params {
    
    self = [super init];
    if (self == nil) {
        return nil;
    }
    _tokenType = MFTOKEN_SERIAL;
    _queryDict = nil;
    _location = nil;
    _host = nil;

    // host
    if (options[HHOST] != nil && [options[HHOST] isKindOfClass:[NSString class]]) {
        _host = options[HHOST];
    }
    // method
    if (options[HMETHOD] != nil && [options[HMETHOD] isKindOfClass:[NSString class]]) {
        self.method = options[HMETHOD];
    } else {
        self.method = DEFAULT_METHOD;
    }
    // HTTP or HTTPS
    if ([options[HSECURE] isEqualToString:@"true"] || ((options[HSECURE] == nil) && [[MFConfig instance] preferSSL])) {
        self.secure = true;
    }
    // headers
    if ((options[HREQHEADERS] != nil) && [options[HREQHEADERS] isKindOfClass:[NSDictionary class]]) {
        self.headers = options[HREQHEADERS];
    }
    // query
    if (params) {
        _queryDict = params;
    }
    // data / path for upload
    NSString* uploadType = options[HUPTYPE];
    if ([uploadType isEqualToString:HUPT_DATA]) {
        // upload a set of bytes.
        self.body = options[HUPDATA];
    } else if ([uploadType isEqualToString:HUPT_PATH]){
        // upload a file from it's path on disk.
        self.localPathForUpload = [NSURL fileURLWithPath:options[HUPPATH]];
    }
    // path for download
    if (options[HLOCALPATH] != nil && [options[HLOCALPATH] isKindOfClass:[NSString class]]) {
        self.localPathForDownload = [NSURL fileURLWithPath:options[HLOCALPATH]];
    }
    // token type
    if ([options[HTOKEN] isEqualToString:HTKT_PARA]) {
        if ([options[HPARALLEL] isEqualToString:HPTT_IMAGE]) {
            _tokenType = MFTOKEN_PARALLEL_IMAGE;
        } else if ([options[HPARALLEL] isEqualToString:HPTT_UPLOAD]) {
            _tokenType = MFTOKEN_PARALLEL_UPLOAD;
        } else {
            erm(invalidField:HPARALLEL);
        }
    } else if ([options[HTOKEN] isEqualToString:HTKT_NONE]) {
        _tokenType = MFTOKEN_NONE;
    } else {
        _tokenType = MFTOKEN_SERIAL;
    }
    // custom client
    if ((options[HCLIENT] != nil) && [options[HCLIENT] isKindOfClass:[NSString class]]) {
        self.httpClientId = options[HCLIENT];
    }
    // description
    if ((options[HDESCRIPTION] != nil) && [options[HDESCRIPTION] isKindOfClass:[NSString class]]) {
        self.desc = options[HDESCRIPTION];
    }
    return self;
}


//------------------------------------------------------------------------------
- (NSURL*)generateURL {
    // sanity checks
    NSString* baseUrl = self.location;
    if ( baseUrl == nil ) {
        erm(nullField:@"location");
        return nil;
    }
    
    NSString* secureUrl = @"";
    if (self.secure) {
        secureUrl = @"s";
    }
    
    NSString* overrideHost = MFREST.host;
    if (self.host) {
        overrideHost = self.host;
    }
    
    // Update url to be fully qualified
    NSString* combinedUrl = [NSString stringWithFormat:@"http%@://%@%@", secureUrl, overrideHost, baseUrl];
    return [NSURL URLWithString:combinedUrl];
    
}



@end
