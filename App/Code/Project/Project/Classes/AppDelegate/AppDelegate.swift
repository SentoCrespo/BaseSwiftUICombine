import SharedUtils
import UIKit
import WUEnvironment

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Bypass for testing purposes
        if WUManagerEnvironment.isTestNoConfig == true {
            return true
        }
        
        Application.shared.configureMainInterface(in: window!)
        
        DeepLinksManager.process(with: launchOptions, window: window)
        
        //		for familyName in UIFont.familyNames {
        //			print(familyName)
        //
        //			for fontName in UIFont.fontNames(forFamilyName: familyName) {
        //				print("\tFont: \(fontName)")
        //			}
        //		}
        
        // Mock Notifications for developing
        //        if Environment.isDebug {
        //            if UIDevice.isSimulator {
        //                UIApplication.shared.listenForRemoteNotifications()
        //                UIApplication.shared.remoteNotificationsPort = 9930 // Default port
        //            }
        //        }
        
        Log.info("*****************************************")
        Log.info("BUNDLE path: \(Bundle.main.bundlePath)")
        Log.info("*****************************************")
        
        Log.info("\n\n ")
        Log.info("*****************************************")
        Log.info("DOCUMENTS path: \(PathUtils.documentsUrl()!) \n\n")
        Log.info("*****************************************")
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationDidEnterBackground(_ application: UIApplication) {}
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // ManagerPushNotifications.resetNotificationsCount()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // ManagerPushNotifications.resetNotificationsCount()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {}
    
    // MARK: URL Scheme
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return DeepLinksManager.process(url: url, window: window)
    }
    
    func openUrl(_ url: URL) {}
    
    // MARK: Remote notifications
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // ManagerPushNotifications.saveDeviceTokenFromData(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        if UIDevice.isSimulator == true {
            // ManagerPushNotifications.saveDeviceTokenFromString("c80902a30b01b1f27b029c5ec95aec53af3648469d0e74225df3fd7a78953253")
            return
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // ManagerPushNotifications.handlePushNotificationReceived(userInfo)
    }
}

// MARK: Global Variables

import Log
var Log: Logger {
    return Application.shared.logger
}

// MARK: Computed Variables

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
}
