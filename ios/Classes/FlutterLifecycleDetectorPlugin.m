#import "FlutterLifecycleDetectorPlugin.h"
#if __has_include(<flutter_lifecycle_detector/flutter_lifecycle_detector-Swift.h>)
#import <flutter_lifecycle_detector/flutter_lifecycle_detector-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_lifecycle_detector-Swift.h"
#endif

@implementation FlutterLifecycleDetectorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterLifecycleDetectorPlugin registerWithRegistrar:registrar];
}
@end
