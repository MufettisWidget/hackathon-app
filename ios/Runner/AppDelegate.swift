import UIKit
import Flutter
import GoogleMaps
import Firebase
import FirebaseCore
import FirebaseDynamicLinks;

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyALnT7pxhQRDuQ3X5RdHEFfUbGtr4w7VL8")
     FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
