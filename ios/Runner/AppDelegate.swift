import UIKit
import Flutter
import workmanager




@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))


    WorkmanagerPlugin.registerTask(withIdentifier:  "be.tramckrijte.workmanagerExample.simpleTask")
    WorkmanagerPlugin.registerTask(withIdentifier: "be.tramckrijte.workmanagerExample.rescheduledTask")
    WorkmanagerPlugin.registerTask(withIdentifier:  "be.tramckrijte.workmanagerExample.failedTask")


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
