//
//  MFErrorMessage.m
//  MediaFireSDK
//
//  Created by Daniel Dean on 8/6/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import "MFErrorMessage.h"
#import "MFErrorLog.h"
#import "NSString+JSONExtender.h"

static inline NSDictionary* build_error(enum ErrorCode code, NSString* message, enum ErrorCategory category) {
    if (message == nil) {
        message = @"";
    }
    return @{ @"error" : [NSNumber numberWithInt:code],
            @"message" : message,
           @"errorcat" : [NSNumber numberWithInt:category] };
}

static inline NSDictionary* build_error_with_data(enum ErrorCode code, NSString* message, enum ErrorCategory category, NSString * key, id object) {
    if (message == nil) {
        message = @"";
    }
    if ((!key.length) || (object == nil)) {
        return build_error(code, message, category);
    }
    return @{ @"error" : [NSNumber numberWithInt:code],
            @"message" : message,
           @"errorcat" : [NSNumber numberWithInt:category],
                   key : object };
}

@implementation MFErrorMessage

//------------------------------------------------------------------------------
+ (BOOL)isErrorMessage:(NSDictionary*)object {
  if ( object == nil ) return NO;
  return [self code:object] != ERRCODE_UNKNOWN &&
         [self category:object] != ERRCAT_UNKNOWN &&
         [self message:object] != nil;
}

//------------------------------------------------------------------------------
+ (BOOL)isAuthenticationError:(NSDictionary *)object {
    // The authentication error code may appear in three places. To be safe,
    // we check all codes in all known places.
    
    if ([self isErrorMessage:object]) {
        NSInteger code = [self code:object];
        
        if ([self isAuthenticationErrorCode:code]) {
            return true;
        }
    }
    
    if (object[@"error"] != nil) {
        id error = object[@"error"];
        if ([error respondsToSelector:@selector(integerValue)]) {
            NSInteger code = [object[@"error"] integerValue];
            
            if ([self isAuthenticationErrorCode:code]) {
                return true;
            }
        }
    }
    
    if (object[@"response"] != nil && [object[@"response"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary* response = object[@"response"];
        
        id error = response[@"error"];
        if ([error respondsToSelector:@selector(integerValue)]) {
            NSInteger code = [response[@"error"] integerValue];
            
            if ([self isAuthenticationErrorCode:code]) {
                return true;
            }
        }
    }
    
    return false;
}

//------------------------------------------------------------------------------
+ (BOOL)isAuthenticationErrorCode:(NSInteger)code {
    BOOL authErr = false;
    
    switch (code) {
        case 102: // missing key
        case 103: // invalid key
        case 107: // invalid creds
        case 108: // invalid user
        case 109: // invalid app id
        case 128: // missing params
        case 129: // invalid params
        case 220: // failed to authenticate to Facebook
        case 232: // failed to authenticate with Facebook because MF email isn't verified
            authErr = true;
            break;
            
        default:
            break;
    }
    
    return authErr;
}

//------------------------------------------------------------------------------
+ (NSInteger)code:(NSDictionary*)errorObject {
    NSNumber* number = errorObject[@"error"];
    if ( number == nil ) return (NSInteger)ERRCODE_UNKNOWN;
    else return [number integerValue];
}

//------------------------------------------------------------------------------
+ (NSInteger)category:(NSDictionary*)errorObject {
    NSNumber* number = errorObject[@"errorcat"];
    if ( number == nil ) return (NSInteger)ERRCAT_UNKNOWN;
    else return [number integerValue];    
}

//------------------------------------------------------------------------------
+ (NSString*)message:(NSDictionary*)errorObject {
    return errorObject[@"message"];
}

//------------------------------------------------------------------------------
+ (NSDictionary*)NullDictionary {
    return build_error(ERRCODE_NULL_DICTIONARY, @"An illegal nil dict was found.", ERRCAT_APP);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)NullCallback {
    return build_error(ERRCODE_NULL_CALLBACK, @"An illegal nil callback was found.", ERRCAT_APP);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)nullField {
    return build_error(ERRCODE_NULL_FIELD, @"An illegal nil string or number was found.", ERRCAT_APP);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)nullField:(NSString*)fieldName {
    return build_error_with_data(ERRCODE_NULL_FIELD, [NSString stringWithFormat:@"An illegal nil value was found: %@.", fieldName], ERRCAT_APP, @"name", fieldName);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)invalidField:(NSString*)fieldName {
    return build_error_with_data(ERRCODE_INVALID_FIELD, @"An invalid string or number was found.", ERRCAT_APP, @"name", fieldName);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)nullURL {
  return build_error(ERRCODE_NULL_URL, @"An illegal nil URL was found.", ERRCAT_APP);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)badResponse:(NSDictionary*)response {
    NSDictionary* error;
    NSInteger apiError = 0;
    // first check for upload response errors
    id doUpload = response[@"doupload"];
    if (doUpload != nil && [doUpload isKindOfClass:[NSDictionary class]]) {
        id doUploadResult = doUpload[@"result"];
        if ([doUploadResult integerValue] == -99) {
            return build_error(ERRCODE_INVALID_SESSION_TOKEN,
                        @"Invalid session token",
                        ERRCAT_API);
        }
        
        return build_error_with_data((NSInteger)ERRCODE_API_ERROR,
                              @"REST API error",
                              ERRCAT_API,
                              @"response",
                              response);
        
    }
    // check for normal api errors
    id errorCode = response[@"error"];
    if ( errorCode == nil ) return build_error_with_data(ERRCODE_UNRECOGNIZED_API_RESPONSE,
                                                         @"API error does not contain error code",
                                                         ERRCAT_API,
                                                         @"response",
                                                         response);
    apiError = [errorCode integerValue];
    switch ( apiError ) {
        case 100:
            error = build_error(ERRCODE_INTERNAL_SERVER_ERROR,
                                @"REST Internal server error",
                                ERRCAT_API);
            break;
        case 105:
            error = build_error(ERRCODE_INVALID_SESSION_TOKEN,
                                @"Invalid session token",
                                ERRCAT_API);
            break;
        case 107:
        case 108:
            error = build_error_with_data(ERRCODE_INVALID_CREDENTIALS,
                                          @"Invalid user credentials",
                                          ERRCAT_API,
                                          @"response",
                                          response);
            break;
        case 109:
            error = build_error_with_data(ERRCODE_INVALID_PARAMETERS,
                                          @"Invalid application ID",
                                          ERRCAT_API,
                                          @"response",
                                          response);
            break;
        case 127:
            error = build_error(ERRCODE_INVALID_SIGNATURE,
                                @"Invalid signature",
                                ERRCAT_API);
            break;
        case 128:
            error = build_error_with_data(ERRCODE_MISSING_PARAMETERS,
                                          @"Missing parameters",
                                          ERRCAT_API,
                                          @"response",
                                          response);
            break;
        case 129:
            error = build_error_with_data(ERRCODE_INVALID_PARAMETERS,
                                          @"Invalid parameters",
                                          ERRCAT_API,
                                          @"response",
                                          response);
            break;
        default:
            error = build_error_with_data((enum ErrorCode)(ERRCODE_API_ERROR + apiError),
                                          @"REST API error",
                                          ERRCAT_API,
                                          @"response",
                                          response);
    }

    return error;
}

//------------------------------------------------------------------------------
+ (NSDictionary*)badHTTP:(NSInteger)status message:(id)response {
    // Response is not guaranteed to be valid JSON. Try to deserialize JSON to
    // find API error 'message'. If failure, keep original response.
    if ([response isKindOfClass:[NSDictionary class]]) {
        return build_error_with_data((enum ErrorCode)(ERRCODE_HTTP_BASE+status), @"Bad HTTP", ERRCAT_API, @"response", response);
    }
    NSDictionary* deserializeJSON = [response deserializeJSON];
    if (deserializeJSON != nil) {
        NSDictionary* responseJSON = deserializeJSON[@"response"];
        if (responseJSON != nil && responseJSON[@"message"]) {
            response = responseJSON[@"message"];
        }
    }
    if ( status < 100 ) {
        return build_error((enum ErrorCode)(ERRCODE_NETWORK_BASE + status), response, ERRCAT_NET);
    } else {
        return build_error((enum ErrorCode)(ERRCODE_HTTP_BASE + status), response, ERRCAT_CLOUD);
    }
}

//------------------------------------------------------------------------------
+ (NSDictionary*)storageLimitExceeded {
    return build_error(ERRCODE_STORAGE_LIMIT_EXCEEDED, @"Upload cannot be completed due to lack of sufficient storage space.", ERRCAT_CLOUD);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)unexpectedResponse:(id)response message:(NSString*)msg {
    return build_error_with_data(ERRCODE_UNRECOGNIZED_API_RESPONSE,
                                 msg,
                                 ERRCAT_CLOUD,
                                 @"response",
                                 response);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)noResponseTo:(NSURL*)url {
    return build_error(ERRCODE_UNRECOGNIZED_API_RESPONSE,
                       [NSString stringWithFormat:@"No response to %@", url],
                       ERRCAT_CLOUD);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)noCurrentSession {
    return build_error(ERRCODE_NO_CURRENT_SESSION, @"No current session", ERRCAT_APP);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)noCredentials {
    return build_error(ERRCODE_NO_CREDENTIALS, @"No credentials were provided", ERRCAT_APP);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)sessionClosed {
    return build_error(ERRCODE_SESSION_CLOSED, @"Session closed", ERRCAT_APP);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)badRequestFormat {
    return build_error(ERRCODE_BAD_FORMAT, @"Request formatting error", ERRCAT_APP);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)cancelled {
    return build_error(ERRCODE_CANCELLED, @"An operation was cancelled", ERRCAT_APP);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)maxPolls {
    return build_error(ERRCODE_MAX_POLLS, @"Maximum number of polls exceeded", ERRCAT_APP);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)bitmapError {
    return build_error(ERRCODE_BITMAP, @"An error occurred during a bitmap operation", ERRCAT_APP);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)badTokenState {
    return build_error(ERRCODE_BAD_TOKEN_STATE, @"A token packet was found to be unlocked when it should be locked, or vice versa.", ERRCAT_APP);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)obtainTokenFailure:(NSDictionary*)response {
    return build_error_with_data(ERRCODE_OBTAIN_TOKEN_FAIL, [NSString stringWithFormat:@"Failed to obtain a new token: %@", response], ERRCAT_APP, @"response", response);
}

//------------------------------------------------------------------------------
+ (NSDictionary*)fileCopyFailed {
    return build_error(ERRCODE_FILECOPY, @"Failed to copy temp file to local path.", ERRCAT_APP);
}


//------------------------------------------------------------------------------
+ (NSDictionary*)log:(NSDictionary*)errorMessage in:(const char*)srcfile at:(NSUInteger)line {
    if ([MFErrorMessage isErrorMessage:errorMessage]) {
        [MFErrorLog in:srcfile at:line message:@"Error : cat [%i] code [%i] message [%@]", [self category:errorMessage], [self code:errorMessage], [self message:errorMessage]];
    } else {
        mflog(@"Error logging ErrorMessage generated in %s at %i. Not a valid ErrorMessage format - %@", srcfile, line, errorMessage);
    }
    
    return errorMessage;
}

@end
