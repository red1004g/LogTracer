#Intro
LogTracer는 iOS를 개발할 때, Log를 쉽게 분석하게 하기 위해 제작되었습니다. 특히, 단위 테스트 및 App 테스트를 할 때, 예기치 못한 현상으로 앱이 중단되거나 원인을 파악하기 쉽게 하기 위한 것을 목표로 합니다.

중/소규모 프로젝트에서 개발자 이외의 사람과 함께 앱 테스트 시, 원인 분석에 효과적으로 사용 될 수 있습니다.

LogTracer는 기본적으로 txt 파일로 저장하는데 itunes의 파일 공유를 통해 쉽게 결과를 확인할 수 있습니다.

#How to use

- `<project-name>-Prefix.pch` 파일에 `LogTrace.h` 파일을 import합니다.

- 만약 ARC 프로젝트를 사용하신다면, 각 파일에 `-fno-objc-arc` flag 를 붙여주세요. [Apple ARC Guidelines](http://developer.apple.com/library/mac/#releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html)

- `AppDelegate.m`파일에 `UncaughtExceptionEngine.h`를 import하고, `[UncaughtExceptionEngine observeUncaughtExceptions];`를 `-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions` 함수 안에 삽입하세요.

#Support

iOS 5.0이상부터 지원됩니다.

#Referece

2개의 homepage를 참고했습니다.

- Catch Uncaught Exception : http://chaosinmotion.com/blog/?p=423
- NSLog Overrding : http://stackoverflow.com/questions/7271528/nslog-into-file
