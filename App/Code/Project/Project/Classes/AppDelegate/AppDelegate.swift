import PRSharedUtils
import UIKit
import WUEnvironment

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    // swiftlint:disable:next weak_delegate
    var appDelegate = AppDelegateFactory.makeDefault()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        // Bypass for testing purposes
        if WUManagerEnvironment.isTestNoConfig == true {
            // Call the composite delegate
            appDelegate = AppDelegateFactory.makeTest()
        }
        
        // Call the composite delegate
        let result = appDelegate.application?(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        return result ?? false

    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Call the composite delegate
        appDelegate.applicationWillResignActive?(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Call the composite delegate
        appDelegate.applicationDidEnterBackground?(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Call the composite delegate
        appDelegate.applicationWillEnterForeground?(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Call the composite delegate
        appDelegate.applicationDidBecomeActive?(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Call the composite delegate
        appDelegate.applicationWillTerminate?(application)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        let result = appDelegate.application?(
            app,
            open: url,
            options: options
        )
        return result ?? false
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Call the composite delegate
        appDelegate.application?(
            application,
            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
        )
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        // Call the composite delegate
        appDelegate.application?(
            application,
            didFailToRegisterForRemoteNotificationsWithError: error
        )

    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // Call the composite delegate
        appDelegate.application?(
            application,
            didReceiveRemoteNotification: userInfo,
            fetchCompletionHandler: completionHandler
        )
        
    }
    
}

// MARK: Global Variables
import Log
var Log: Logger {
    let delegate = AppDelegate
        .shared
        .compositeDelegate?
        .delegate(
            type: AppDelegateThirdParty.self
    )
    return delegate?.logger ?? ConsoleLogger()
}

// MARK: Computed Variables
extension AppDelegate {
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
    
    var compositeDelegate: CompositeAppDelegate? {
        return AppDelegate.shared.appDelegate as? CompositeAppDelegate
    }

    var datasource: DataSourceConfiguration? {
        let delegate = compositeDelegate?.delegate(type: AppDelegateConfigurations.self)
        return delegate?.dataSourceConfiguration
    }
    
}
