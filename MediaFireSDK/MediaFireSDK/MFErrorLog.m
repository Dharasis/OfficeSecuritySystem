//
//  MFErrorLog.m
//  MediaFireSDK
//
//  Created by Ken Hartness on 10/2/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import "MFErrorLog.h"

extern void MFCaptureLogMessage(NSString* message);

@implementation MFErrorLog

//------------------------------------------------------------------------------
+ (void)in:(const char*)srcfile at:(NSUInteger)line message:(NSString*)msg, ... {
    va_list arglist;
    
    va_start(arglist, msg);
    NSString* message      = [[NSString alloc] initWithFormat:msg arguments:arglist];
    NSString* source       = [[[NSString stringWithFormat:@"%s", srcfile] lastPathComponent] stringByDeletingPathExtension];
    NSString* sourcePadded = [source stringByPaddingToLength:20 withString: @" " startingAtIndex:0];
    NSString* linePadded   = [[@(line) stringValue] stringByPaddingToLength:5 withString: @" " startingAtIndex:0];

#if defined(DEBUG)
    NSString* consoleMessage = [NSString stringWithFormat:@"📒%@ 📌%@ 📎%@",
                                sourcePadded,
                                linePadded,
                                message];
    
    NSLog(@"%@",consoleMessage);
#endif

    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString* captureMessage = [NSString stringWithFormat:@"%@ [|[%@ %@]|] %@",
                                [dateFormatter stringFromDate:[NSDate date]],
                                sourcePadded,
                                linePadded,
                                message];
    
    
    MFCaptureLogMessage(captureMessage);

    va_end(arglist);
}


@end
