import Domain
import Foundation
import UIKit
import WUEnvironment
import Log
import PlatformNetworkApi

final class Application {
    static let shared = Application()
    
    var logger: Logger!
    var environment: ApiEnvironment
    var dataSourceConfiguration: DataSourceConfiguration
    
    private init() {
        // TODO:
        self.environment = .debug
        self.dataSourceConfiguration = DataSourceConfiguration()
        
        if WUManagerEnvironment.isReleaseFlag || WUManagerEnvironment.isAdhocFlag {
            self.logger = ConsoleLogger() // TODO: CrashlyticsLogger()
        } else {
            self.logger = ConsoleLogger()
        }
        
        self.initKeyboardManager()
        self.initCrashlytics()
        self.initHUD()
        self.trackVersion()
        self.customizeAppearence()
    }
}

extension Application {
    func configureMainInterface(in window: UIWindow) {
        self.showLogin(in: window)
    }
    
    func showLogin(in window: UIWindow) {
        let navigationController = PRNavigationController()
        let configurator = MainConfigurator(dataSource: self.dataSourceConfiguration)
        let navigator = MainNavigator(configurator: configurator, navigationController: navigationController)
        window.replaceAnimated(navigationController: navigationController)
        
        navigator.toView()
    }
}

import AppVersionMonitor
import IQKeyboardManager
import PKHUD

extension Application {
    fileprivate func initKeyboardManager() {
        IQKeyboardManager.shared().isEnabled = true
    }
    
    fileprivate func initCrashlytics() {
        // TODO: Uncomment when ready
//        Fabric.with( [ Crashlytics.self ] )
    }
    
    fileprivate func initHUD() {
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
    }
}

extension Application {
    fileprivate func trackVersion() {
        AppVersionMonitor.sharedMonitor.startup()
    }
    
    fileprivate func customizeAppearence() {
        // Custom image for back
        
        //        let backArrowImage = UIImage(named: BackArrow)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        //        UINavigationBar.appearance().backIndicatorImage = backArrowImage
        //        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backArrowImage
        
        // Customize navigation bar
        let fontColor = UIColor.fontPrimaryDark1
        let backgroundColor = UIColor.barTintColor
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: fontColor
        ]
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = fontColor
        UINavigationBar.appearance().barTintColor = backgroundColor
        UINavigationBar.appearance().backgroundImage(for: .default)
        
        // Custom appearence
        
        //        UISwitch.appearance().onTintColor = secondaryTextColor
        //        UIStepper.appearance().tintColor = secondaryTextColor
    }

}
