import Foundation
import UIKit

/// Perform startup configurations, e.g. build UI stack, setup UIApperance
class AppDelegateStartup: AppDelegateType {

    // MARK: - Properties
    var window: UIWindow?
    
    // MARK: - Life Cycle
    
}

extension AppDelegateStartup {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        self.configureMainInterface(in: window!)
        
        return true
    }
    
}

private extension AppDelegateStartup {
    
    func configureMainInterface(in window: UIWindow) {
        self.showLogin(in: window)
    }
    
    func showLogin(in window: UIWindow) {
        let navigationController = PRNavigationController()
        let dataSourceConfiguration = AppDelegate.shared.datasource!
        let configurator = MainConfigurator(dataSource: dataSourceConfiguration)
        let navigator = MainNavigator(configurator: configurator, navigationController: navigationController)
        window.replaceAnimated(navigationController: navigationController)
        
        navigator.toView()
    }
        
}
