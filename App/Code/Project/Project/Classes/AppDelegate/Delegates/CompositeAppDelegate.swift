import Foundation

typealias AppDelegateType = UIResponder & UIApplicationDelegate

class CompositeAppDelegate: AppDelegateType {
    
    // MARK: - Properties
    private let appDelegates: [AppDelegateType]
    
    // MARK: - Life Cycle
    init(appDelegates: [AppDelegateType]) {
        self.appDelegates = appDelegates
    }
    
}

// MARK: - AppDelegate
extension CompositeAppDelegate {
    
    @discardableResult
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appDelegates.forEach {
            _ = $0.application?(
                application,
                didFinishLaunchingWithOptions: launchOptions
            )
        }
        return true
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        appDelegates.forEach {
            _ = $0.applicationWillResignActive?(application)
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        appDelegates.forEach {
            _ = $0.applicationDidEnterBackground?(application)
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        appDelegates.forEach {
            _ = $0.applicationWillEnterForeground?(application)
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        appDelegates.forEach {
            _ = $0.applicationDidBecomeActive?(application)
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        appDelegates.forEach {
            _ = $0.applicationWillTerminate?(application)
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        let result = appDelegates
            .allSatisfy {
                return $0.application?(app, open: url, options: options) ?? false
        }
        return result
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        appDelegates.forEach {
            _ = $0.application?(
                application,
                didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
            )
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        appDelegates.forEach {
            _ = $0.application?(
                application,
                didFailToRegisterForRemoteNotificationsWithError: error
            )
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        appDelegates.forEach {
            _ = $0.application?(
                application,
                didReceiveRemoteNotification: userInfo,
                fetchCompletionHandler: completionHandler
            )
        }
    }
    
}

// MARK: - Public Methods
extension CompositeAppDelegate {
    
    func delegate<T: AppDelegateType>(type: T.Type) -> T? {
        let result = appDelegates
            .first(where: {
                return $0 is T
            }).flatMap {
                return $0 as? T
        }
        return result
    }
    
}
