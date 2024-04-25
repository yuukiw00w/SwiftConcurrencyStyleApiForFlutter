import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        guard let controller: FlutterViewController = window?.rootViewController as? FlutterViewController else {
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
        
        GeneratedPluginRegistrant.register(with: self)
        
        let binaryMessanger = controller.binaryMessenger
        if #available(iOS 13, *) {
            let callFromNative = CallFromNative(binaryMessenger: binaryMessanger)
            let sampleApi = SampleApiImpl(callFromNative: callFromNative)
            SampleApiSetup.setUp(binaryMessenger: binaryMessanger, api: sampleApi)
        } else {
            let callFromNative = CallFromNativeLegacy(binaryMessenger: binaryMessanger)
            let sampleApi = SampleApiLegacyImpl(callFromNative: callFromNative)
            SampleApiSetup.setUp(binaryMessenger: binaryMessanger, api: sampleApi)
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
