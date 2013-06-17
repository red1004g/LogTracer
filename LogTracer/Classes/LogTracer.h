//
//  Log.h
//  LogTracer
//
//  Created by Cho Byung Hoon on 13. 6. 17..
//  Copyright (c) 2013년 Cho Byung Hoon. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef WRITE_TO_FILE
#define WRITE_TO_FILE YES
#endif

#define NSLog(args...)       _Log(@"DEBUG  ",  __LINE__, __PRETTY_FUNCTION__, args);

#if TARGET_OS_IPHONE
#define NSLogDebug(args...)  _Log(@"DEBUG  ",  __LINE__, __PRETTY_FUNCTION__, args);
#define NSLogInfo(args...)   _Log(@"INFO   ",   __LINE__, __PRETTY_FUNCTION__, args);
#define NSLogAssert(args...) _Log(@"ASSERT ", __LINE__, __PRETTY_FUNCTION__, args);
#define NSLogError(args...)  _Log(@"ERROR  ",  __LINE__, __PRETTY_FUNCTION__, args);
#else
#define NSLogDebug(args...)
#define NSLogInfo(args...)
#define NSLogAssert(args...)
#define NSLogError(args...)
#endif


@interface LogTracer : NSObject

/* Override NSLog */
void _Log(NSString *prefix, int line, const char *funcName, NSString *format, ...);
@end
