// swiftlint:disable line_length
import Foundation
import UIKit

/// Performs configuration & handles remote notifications
class SceneDelegateRemoteNotifications: SceneDelegateType {
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
}

// MARK: - App Delegate
extension SceneDelegateRemoteNotifications {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // TODO: Check if app lauched via notification
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // TODO: Decode & Store & Handle token changes
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // TODO: Handle case
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // TODO: Handle case
    }
    
}

// MARK: - Scene Delegate
extension SceneDelegateRemoteNotifications {
    
}
