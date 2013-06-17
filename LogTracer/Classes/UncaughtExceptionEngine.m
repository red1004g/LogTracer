//
//  CatchUncaughtExceptions.m
//  LogTracer
//
//  Created by Cho Byung Hoon on 13. 6. 17..
//  Copyright (c) 2013년 Cho Byung Hoon. All rights reserved.
//

#import "UncaughtExceptionEngine.h"
#include <execinfo.h>

@interface UncaughtExceptionEngine ()

void startObservaction();
void SetupUncaughtSignals();
void handleUncaughtException(NSException *exception);
void handleUncaughtSignal(int sig, siginfo_t *info, void *context);
@end

@implementation UncaughtExceptionEngine

+ (void)observeUncaughtExceptions {
    startObservation();
}

void startObservation() {
    NSSetUncaughtExceptionHandler(&handleUncaughtException);
	SetupUncaughtSignals();
}

void SetupUncaughtSignals() {
	struct sigaction signalAction;
	signalAction.sa_sigaction = handleUncaughtSignal;
	signalAction.sa_flags = SA_SIGINFO;
	
	sigemptyset(&signalAction.sa_mask);
	sigaction(SIGQUIT, &signalAction, NULL);
	sigaction(SIGILL, &signalAction, NULL);
	sigaction(SIGTRAP, &signalAction, NULL);
	sigaction(SIGABRT, &signalAction, NULL);
	sigaction(SIGEMT, &signalAction, NULL);
	sigaction(SIGFPE, &signalAction, NULL);
	sigaction(SIGBUS, &signalAction, NULL);
	sigaction(SIGSEGV, &signalAction, NULL);
	sigaction(SIGSYS, &signalAction, NULL);
	sigaction(SIGPIPE, &signalAction, NULL);
	sigaction(SIGALRM, &signalAction, NULL);
	sigaction(SIGXCPU, &signalAction, NULL);
	sigaction(SIGXFSZ, &signalAction, NULL);
}

void handleUncaughtException(NSException *exception) {
    
	/* Extract the call stack */
	
	NSArray *callStack = [exception callStackReturnAddresses];
	int i,len = [callStack count];
    void **frames = malloc(sizeof(void *)* len);
	
	for (i = 0; i < len; ++i) {
		frames[i] = (void *)[[callStack objectAtIndex:i] unsignedIntegerValue];
	}

	char **symbols = backtrace_symbols(frames,len);
    
	/* Now format into a message for sending to the user */
	
	NSMutableString *buffer = [[NSMutableString alloc] initWithCapacity:4096];
	
	NSBundle *bundle = [NSBundle mainBundle];
	[buffer appendFormat:@"%@ version %@ build %@\n\n",
                        [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                        [bundle objectForInfoDictionaryKey:@"CFBundleVersion"],
                        [bundle objectForInfoDictionaryKey:@"CIMBuildNumber"]];
	[buffer appendString:@"Uncaught Exception\n"];
	[buffer appendFormat:@"Exception Name: %@\n",[exception name]];
	[buffer appendFormat:@"Exception Reason: %@\n",[exception reason]];
	[buffer appendString:@"Stack trace:\n\n"];
	for (i = 0; i < len; ++i) {
		[buffer appendFormat:@"%4d - %s\n",i,symbols[i]];
	}
    
	NSLogError(@"%@", buffer);

    free(frames);
	exit(0);
}

void handleUncaughtSignal(int sig, siginfo_t *info, void *context) {
	void *frames[128];
	int i,len = backtrace(frames, 128);
	char **symbols = backtrace_symbols(frames,len);
	
	/* Now format into a message for sending to the user */
	
	NSMutableString *buffer = [[NSMutableString alloc] initWithCapacity:4096];
	
	NSBundle *bundle = [NSBundle mainBundle];
    [buffer appendFormat:@"%@ version %@ build %@\n\n",
                        [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                        [bundle objectForInfoDictionaryKey:@"CFBundleVersion"],
                        [bundle objectForInfoDictionaryKey:@"CIMBuildNumber"]];
	[buffer appendString:@"Uncaught Signal\n"];
	[buffer appendFormat:@"si_signo    %d\n",info->si_signo];
	[buffer appendFormat:@"si_code     %d\n",info->si_code];
	[buffer appendFormat:@"si_value    %d\n",info->si_value];
	[buffer appendFormat:@"si_errno    %d\n",info->si_errno];
	[buffer appendFormat:@"si_addr     0x%08lX\n",info->si_addr];
	[buffer appendFormat:@"si_status   %d\n",info->si_status];
	[buffer appendString:@"Stack trace:\n\n"];
	for (i = 0; i < len; ++i) {
		[buffer appendFormat:@"%4d - %s\n",i,symbols[i]];
	}
	
	NSLogError(@"System Error : %@",buffer);
	exit(0);
}

@end
