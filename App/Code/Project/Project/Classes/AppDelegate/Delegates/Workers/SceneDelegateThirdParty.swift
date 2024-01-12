import Foundation
import UIKit
import Log

/// Setup Third Party dependencies
class SceneDelegateThirdParty: SceneDelegateType {
    
    // MARK: - Properties
    var logger: Logger!
    
    // MARK: - Life Cycle
    
}

// MARK: - App Delegate
extension SceneDelegateThirdParty {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
          
        self.initLogger()
        self.initKeyboardManager()
        self.initCrashlytics()
        self.initHUD()
        self.trackVersion()
        self.customizeAppearence()
        
        return true
    }
    
}

// MARK: - Scene Delegate
extension SceneDelegateThirdParty {
   
}

private extension SceneDelegateThirdParty {
    
    func initLogger() {
//        if WUManagerEnvironment.isReleaseFlag || WUManagerEnvironment.isAdhocFlag {
//            self.logger = ConsoleLogger() // TODO: CrashlyticsLogger()
//        } else {
//            self.logger = ConsoleLogger()
//        }
    }
    
    func initKeyboardManager() {
//        IQKeyboardManager.shared().isEnabled = true
    }
    
    func initCrashlytics() {
        // TODO: Uncomment when ready
        //        Fabric.with( [ Crashlytics.self ] )
    }
    
    func initHUD() {
//        PKHUD.sharedHUD.dimsBackground = false
//        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
    }
    
}

private extension SceneDelegateThirdParty {
    
    func trackVersion() {
//        AppVersionMonitor.sharedMonitor.startup()
    }
    
    func customizeAppearence() {
        // Custom image for back
        
        //        let backArrowImage = UIImage(named: BackArrow)?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        //        UINavigationBar.appearance().backIndicatorImage = backArrowImage
        //        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backArrowImage
        
        // Customize navigation bar
//        let fontColor = UIColor.fontPrimaryDark1
//        let backgroundColor = UIColor.barTintColor
//        
//        UINavigationBar.appearance().titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: fontColor
//        ]
//        
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().tintColor = fontColor
//        UINavigationBar.appearance().barTintColor = backgroundColor
//        UINavigationBar.appearance().backgroundImage(for: .default)
        
        // Custom appearence
        
        //        UISwitch.appearance().onTintColor = secondaryTextColor
        //        UIStepper.appearance().tintColor = secondaryTextColor
    }
    
}
