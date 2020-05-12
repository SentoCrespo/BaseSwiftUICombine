import Foundation
import WUEnvironment

/// Performs configuration & handles remote notifications
class AppDelegateRemoteNotifications: AppDelegateType {
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
}

extension AppDelegateRemoteNotifications {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // TODO: Check if app lauched via notification
        
        // Mock Notifications for developing
        if WUManagerEnvironment.isDebugFlag {
            if UIDevice.isSimulator {
                UIApplication.shared.listenForRemoteNotifications()
                UIApplication.shared.remoteNotificationsPort = 9930 // Default port
            }
        }
        
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
