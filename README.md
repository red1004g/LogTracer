# A simple and lightweight log trace For iOS
When you are developing iOS, LogTracer was made in order to easily analyze the Log. This was made in order to understand why the App is interrupted. In addition, you can efficiently manage to the unit test and app testing with when developing with people of non-developers in a project of small & medium.

LogTracer는 기본적으로 txt 파일로 저장하는데 itunes의 파일 공유를 통해 쉽게 결과를 확인할 수 있습니다.

# How to use

At First, add files to your project:
  LogTracer.h
  LogTracer.m
  UncaughtExceptionEngine.h
  UncaughtExceptionEngine.m

Second, In `<project-name>-Prefix.pch`:
  import "LogTracer.h"

Then In `AppDelegate.m`:
  import "UncaughtExceptionEngine.h"

Finally, In `-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`:
  insert `[UncaughtExceptionEngine objserveUncaughtExceptions];`

If, Using ARC project [Apple ARC Guidelines](http://developer.apple.com/library/mac/#releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html):
  insert flat `-fno-objc-arc`


# Write to file

In order to config writing to file In `LogTracer.h`:
  #define WRITE_TO_FILE YES // YES : write to log file, NO : delete log file

#Support

All version support for you

#Referece

- Catch Uncaught Exception : http://chaosinmotion.com/blog/?p=423

- NSLog Overrding : http://stackoverflow.com/questions/7271528/nslog-into-file
