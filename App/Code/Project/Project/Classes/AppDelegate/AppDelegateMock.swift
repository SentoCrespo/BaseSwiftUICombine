import Foundation

class AppDelegateMock: AppDelegateType {
    
    // MARK: - Properties
    var methodCalled: [String: Bool] = [:]
    
    // MARK: - Life Cycle
    
}

// MARK: - AppDelegate
extension AppDelegateMock {
    
    @discardableResult
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        methodCalled["didFinishLaunchingWithOptions"] = true
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        methodCalled["applicationWillResignActive"] = true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        methodCalled["applicationDidEnterBackground"] = true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        methodCalled["applicationWillEnterForeground"] = true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        methodCalled["applicationDidBecomeActive"] = true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        methodCalled["applicationWillTerminate"] = true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        methodCalled["openUrlOptions"] = true
        return false
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        methodCalled["didRegisterForRemoteNotificationsWithDeviceToken"] = true
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        methodCalled["didFailToRegisterForRemoteNotificationsWithError"] = true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        methodCalled["didReceiveRemoteNotification"] = true
    }
    
}
