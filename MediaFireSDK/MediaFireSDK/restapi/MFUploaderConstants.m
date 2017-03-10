//
//  MFUploaderConstants.m
//  MediaFireSDK
//
//  Created by Mike Jablonski on 3/5/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import "MFUploaderConstants.h"

// Event and status names for upload transaction
NSString* const UEVENT   = @"upl_event";
NSString* const UESETUP  = @"setup_complete";
NSString* const UECHUNK  = @"chunk_complete";
NSString* const UECHUNKS = @"chunks_complete";
NSString* const UEPOLL   = @"poll_wait";
NSString* const UEHANG   = @"recoverable_error";
NSString* const UEFAIL   = @"fail";
NSString* const UESUCCESS= @"success";
NSString* const UCHUNKID = @"chunk_id";

// Field names for upload info.
NSString* const UQUICKKEY    = @"quickkey";
NSString* const UFILENAME    = @"filename";
NSString* const UFILEPATH    = @"path";
NSString* const UUPLOADDATA  = @"uploaddata";
NSString* const UFILEHASH    = @"filehash";
NSString* const UUPLOADKEY   = @"uploadkey";
NSString* const UFOLDERKEY   = @"folderkey";
NSString* const USTATUS      = @"status";
NSString* const UFILESIZE    = @"filesize";
NSString* const ULASTUNIT    = @"lastunit";
NSString* const UUNITSIZE    = @"unitsize";
NSString* const UUNITCOUNT   = @"unitcount";
NSString* const UIDENT       = @"identifier";