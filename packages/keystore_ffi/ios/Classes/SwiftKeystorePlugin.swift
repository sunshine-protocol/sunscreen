import Flutter
import UIKit

public class SwiftKeystorePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    // Noop
    result(nil)
  }

  public static func dummyMethodToEnforceBundling() {
    keystore_new()
  }
}
