//
//  Log.m
//  LogTracer
//
//  Created by Cho Byung Hoon on 13. 6. 17..
//  Copyright (c) 2013년 Cho Byung Hoon. All rights reserved.
//

#import "LogTracer.h"

@interface LogTracer()

void appendLogInFile(NSString *prefix, int line, const char *funcName, const char *time, NSString *message);
void appendLine(NSString *logFilePath, NSString *logMsg);
const char *getDate();

@end

@implementation LogTracer

void _Log(NSString *prefix, int line, const char *funcName, NSString *format, ...) {
    va_list argumentList;
    va_start (argumentList, format);
    format = [format stringByAppendingString:@"\n"];
    NSString *msg = [[NSString alloc] initWithFormat:[NSString stringWithFormat:@"%@",format] arguments:argumentList];
    va_end (argumentList);

    fprintf(stderr,"%s[%s]:%s:%d - %s", [prefix UTF8String], getDate(), funcName, line, [msg UTF8String]);
    
#if WRITE_TO_FILE
    createLogFile();
    appendLogInFile(prefix, line, funcName, currentDate, msg);
#else
    deleteLogFile();
#endif
    
    [msg release];
}

#pragma mark - Config Log file

void createLogFile() {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSString *logDirectoryPath = [documentPath stringByAppendingPathComponent:@"Logs"];
    NSString *logFilePath = [documentPath stringByAppendingPathComponent:@"Logs/log.text"];
    NSError *error = nil;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:logDirectoryPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:logDirectoryPath
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error];
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:logFilePath]){
        [[NSData data] writeToFile:logFilePath atomically:YES];
    }
}

void deleteLogFile() {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSString *logDirectoryPath = [documentPath stringByAppendingPathComponent:@"Logs"];
    NSError *error = nil;

    if (![[NSFileManager defaultManager] fileExistsAtPath:logDirectoryPath]){
        [[NSFileManager defaultManager] removeItemAtPath:logDirectoryPath error:&error];
    }
}

#pragma mark - Append logs in file

void appendLogInFile(NSString *prefix, int line, const char *funcName, const char *time, NSString *message) {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSString *logFilePath = [documentPath stringByAppendingPathComponent:@"Logs/log.text"];
    
    appendLine(logFilePath, [NSString stringWithFormat:@"%@%s[%s]:%d - %@", prefix, funcName, time, line, message]);
}

void appendLine(NSString *logFilePath, NSString *logMsg) {
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    [handle writeData:[logMsg dataUsingEncoding:NSUTF8StringEncoding]];
    [handle closeFile];
}
                                      
const char *getDate() {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];

    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:[NSDate date]]];
    
    return [timeStamp UTF8String];
}

@end