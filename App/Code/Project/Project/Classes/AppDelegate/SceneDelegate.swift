import Foundation
import UIKit
import SwiftUI
import WUEnvironment

@UIApplicationMain
class SceneDelegate: UIResponder {
    
    // MARK: - Properties
    var window: UIWindow?
    // swiftlint:disable:next weak_delegate
    var sceneDelegate = SceneDelegateFactory.makeDefault()
}

// MARK: - AppDelegate
extension SceneDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        // Bypass for testing purposes
        if WUManagerEnvironment.isTestNoConfig == true {
            // Call the composite delegate
            sceneDelegate = SceneDelegateFactory.makeTest()
        }
        
        // Call the composite delegate
        let result = sceneDelegate.application?(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        return result ?? false

    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Call the composite delegate
        sceneDelegate.applicationWillResignActive?(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Call the composite delegate
        sceneDelegate.applicationDidEnterBackground?(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Call the composite delegate
        sceneDelegate.applicationWillEnterForeground?(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Call the composite delegate
        sceneDelegate.applicationDidBecomeActive?(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Call the composite delegate
        sceneDelegate.applicationWillTerminate?(application)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        let result = sceneDelegate.application?(
            app,
            open: url,
            options: options
        )
        return result ?? false
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Call the composite delegate
        sceneDelegate.application?(
            application,
            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken
        )
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        // Call the composite delegate
        sceneDelegate.application?(
            application,
            didFailToRegisterForRemoteNotificationsWithError: error
        )

    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // Call the composite delegate
        sceneDelegate.application?(
            application,
            didReceiveRemoteNotification: userInfo,
            fetchCompletionHandler: completionHandler
        )
        
    }
    
}

// MARK: - UIWindowSceneDelegate
extension SceneDelegate: UIWindowSceneDelegate {
    
    func windowScene(_ windowScene: UIWindowScene, didUpdate previousCoordinateSpace: UICoordinateSpace, interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation, traitCollection previousTraitCollection: UITraitCollection) {
     
    }

    /// Called when the user activates your application by selecting a shortcut on the home screen,
    /// and the window scene is already connected.
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
    }
    
}

// MARK: - UISceneDelegate
extension SceneDelegate: UISceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Call the composite delegate
        sceneDelegate.scene?(
            scene,
            willConnectTo: session,
            options: connectionOptions
        )
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
        // Call the composite delegate
        sceneDelegate.sceneDidDisconnect?(scene)
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
        // Call the composite delegate
        sceneDelegate.sceneDidBecomeActive?(scene)
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
        // Call the composite delegate
        sceneDelegate.sceneWillResignActive?(scene)
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
        // Call the composite delegate
        sceneDelegate.sceneWillEnterForeground?(scene)
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
        // Call the composite delegate
        sceneDelegate.sceneDidEnterBackground?(scene)
        
    }
    
}

// MARK: Global Variables
import Log
var Log: Logger {
    let delegate = SceneDelegate
        .shared
        .compositeDelegate?
        .delegate(
            type: SceneDelegateThirdParty.self
    )
    return delegate?.logger ?? ConsoleLogger()
}

// MARK: Computed Variables
extension SceneDelegate {
    
    static var shared: SceneDelegate {
        return UIApplication.shared.delegate as? SceneDelegate ?? SceneDelegate()
    }
    
    var compositeDelegate: CompositeSceneDelegate? {
        return SceneDelegate.shared.sceneDelegate as? CompositeSceneDelegate
    }

    var datasource: DataSourceConfiguration? {
        let delegate = compositeDelegate?.delegate(type: SceneDelegateConfigurations.self)
        return delegate?.dataSourceConfiguration
    }
    
}
