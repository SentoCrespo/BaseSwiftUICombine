// swiftlint:disable line_length
import Foundation
import UIKit
import SwiftUI

/// Perform startup configurations, e.g. build UI stack, setup UIApperance
class SceneDelegateStartup: SceneDelegateType {

    // MARK: - Properties
    var window: UIWindow?
    
    // MARK: - Life Cycle
    
}

// MARK: - Scene Delegate
extension SceneDelegateStartup {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else {
            fatalError("No window scene found")
        }
        
        // Create the main window
        self.window = UIWindow(windowScene: windowScene)
        self.configureMainInterface(in: self.window!)
    }
    
}

// MARK: - Private Methods
private extension SceneDelegateStartup {
    
    func configureMainInterface(in window: UIWindow) {
        self.showMain(in: window)
    }
    
    func showMain(in window: UIWindow) {
        // Instantiate SwiftUI Container with root View
        let navigationController = UINavigationController()
        
        // Main scene
//        let configurator = MainConfigurator.default
//        var render = MainRender(
//            configurator: configurator
//        )
        
        // HeroList
        let configurator = HeroListConfigurator.default
        let render = HeroListRender(
            configurator: configurator
        )
        let initialView = render.view(navigationController: navigationController)
        
        navigationController.pushViewController(
            UIHostingController(rootView: initialView),
            animated: true
        )
        
        window.rootViewController = navigationController
        
        // Make the window become active
        window.makeKeyAndVisible()
    }
        
}
