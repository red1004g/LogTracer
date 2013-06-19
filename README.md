# Log Tracer For iOS
iOS Application을 만들 때, LogTracer는 다양한 상황에 대한 로그들을 파일로 제공하기 위해 만들어졌습니다. App의 갑자기 종료되거나 충돌에 대한 원인을 쉽게 분석해보세요. 특히, 비-개발자분들과 함께 App 테스팅 시 효과적으로 원인을 분석 할 수 있습니다.

# 사용방법

- 프로젝트에 파일 추가
```
  LogTracer.h
  LogTracer.m
  UncaughtExceptionEngine.h
  UncaughtExceptionEngine.m
```

- `<project-name>-Prefix.pch`에 import
```
  import "LogTracer.h"
```

- `AppDelegate.m`에 import
```
  import "UncaughtExceptionEngine.h"
```

- `-(BOOL)application:didFinishLaunchingWithOptions:`에 추가
```
  [UncaughtExceptionEngine objserveUncaughtExceptions];
```

- 만약 ARC 프로젝트 사용할 경우 flag 추가([Apple ARC Guidelines](http://developer.apple.com/library/mac/#releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html))
```
  `-fno-objc-arc`
```


# 로그 파일 쓰기

- `LogTracer.h`의 `#define`으로 설정할 수 있습니다.

- 만약 NO를 설정할 경우, 폴더까지 모두 지워집니다.

```objc
  #define WRITE_TO_FILE YES // YES : write to log file, NO : delete log file
```

# 로그 파일 보기

- iTunes에서 `응용 프로그램` > `파일 공유` > `앱 이름` > `Log 폴더`를 다운받으시면 됩니다.

#Support

- 모든 버전에서 호환됩니다.

#Referece

- Catch Uncaught Exception : http://chaosinmotion.com/blog/?p=423

- NSLog Overrding : http://stackoverflow.com/questions/7271528/nslog-into-file
