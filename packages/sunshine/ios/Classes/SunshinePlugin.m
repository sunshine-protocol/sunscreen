#import "SunshinePlugin.h"
#if __has_include(<sunshine/sunshine-Swift.h>)
#import <sunshine/sunshine-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "sunshine-Swift.h"
#endif

@implementation SunshinePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSunshinePlugin registerWithRegistrar:registrar];
}
@end
