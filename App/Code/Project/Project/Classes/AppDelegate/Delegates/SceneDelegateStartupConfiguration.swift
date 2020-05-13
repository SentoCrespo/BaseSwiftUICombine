import Foundation
import UIKit
import SwiftUI

/// Perform startup configurations, e.g. build UI stack, setup UIApperance
class SceneDelegateStartup: SceneDelegateType {

    // MARK: - Properties
    var window: UIWindow?
    
    // MARK: - Life Cycle
    
}

// MARK: - App Delegate
extension SceneDelegateStartup {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        self.configureMainInterface(in: window!)
        
        return true
    }
    
}

// MARK: - Scene Delegate
extension SceneDelegateStartup {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else {
            fatalError("No window scene found")
        }
        
        // Create the main window
        self.window = UIWindow(windowScene: windowScene)
        
    }
    
}

// MARK: - Private Methods
private extension SceneDelegateStartup {
    
    func configureMainInterface(in window: UIWindow) {
        self.showMain(in: window)
    }
    
    func showMain(in window: UIWindow) {
        // Instantiate SwiftUI Container with root View
        let initialView = MainUIView()
        let vc = UIHostingController(rootView: initialView)
        window.rootViewController = vc
        
        // Make the window become active
        window.makeKeyAndVisible()
    }
        
}
