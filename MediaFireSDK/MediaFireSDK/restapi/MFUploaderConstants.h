//
//  MFUploaderConstants.h
//  MediaFireSDK
//
//  Created by Mike Jablonski on 3/5/14.
//  Copyright (c) 2014 MediaFire. All rights reserved.
//

#import <Foundation/Foundation.h>

/** @brief The name of the "upload event" property in an upload callback response. */
extern NSString* const UEVENT;
/** @brief The value of UEVENT when pre-upload/check is complete.  */
extern NSString* const UESETUP;
/** @brief The value of UEVENT when a unit was uploaded successfully. */
extern NSString* const UECHUNK;
/** @brief The value of UEVENT when all units uploaded successfully. */
extern NSString* const UECHUNKS;
/** @brief The value of UEVENT when polling, no key yet. */
extern NSString* const UEPOLL;
/** @brief The value of UEVENT when a non-fatal error occurs during poll upload. */
extern NSString* const UEHANG;
/** @brief The value of UEVENT when an upload fails. */
extern NSString* const UEFAIL;
/** @brief The value of UEVENT when an upload completes successfully. */
extern NSString* const UESUCCESS;
/** @brief The name of the "chunk id" property in an upload callback response. */
extern NSString* const UCHUNKID;

// Field names for upload info.
/** @brief The name of the "quickkey" property in a file properties dictionary.*/
extern NSString* const UQUICKKEY;
/** @brief The name of the "file name" property in a file properties dictionary.*/
extern NSString* const UFILENAME;
/** @brief The name of the "file path" property in a file properties dictionary.*/
extern NSString* const UFILEPATH;
/** @brief The name of the "upload data" property in a file properties dictionary.*/
extern NSString* const UUPLOADDATA;
/** @brief The name of the "file hash" property in a file properties dictionary.*/
extern NSString* const UFILEHASH;
/** @brief The name of the "upload key" property in a file properties dictionary.*/
extern NSString* const UUPLOADKEY;
/** @brief The name of the "upload folder key" property in a file properties dictionary.*/
extern NSString* const UFOLDERKEY;
/** @brief The name of the "status" property in a file properties dictionary.*/
extern NSString* const USTATUS;
/** @brief The name of the "file size" property in a file properties dictionary.*/
extern NSString* const UFILESIZE;
/** @brief The name of the "last unit" property in a file properties dictionary. */
extern NSString* const ULASTUNIT;
/** @brief The name of the "unit size" property in a file properties dictionary. */
extern NSString* const UUNITSIZE;
/** @brief The name of the "total number of units" property in a file properties dictionary.*/
extern NSString* const UUNITCOUNT;
/** @brief The name of the "identifier" property in a file properties dictionary.*/
extern NSString* const UIDENT;
