#import "KeystorePlugin.h"
#if __has_include(<keystore/keystore-Swift.h>)
#import <keystore/keystore-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "keystore-Swift.h"
#endif

@implementation KeystorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKeystorePlugin registerWithRegistrar:registrar];
}
@end
