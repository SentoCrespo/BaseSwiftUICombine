// swiftlint:disable line_length
import Foundation
import UIKit

/// Performs debugging info
class SceneDelegateDebug: SceneDelegateType {

    // MARK: - Properties
    
    // MARK: - Life Cycle
    
}

// MARK: - App Delegate
extension SceneDelegateDebug {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        // self.printAvailableFonts()
        self.printPathNames()
        
        return true
    }
    
}

// MARK: - Scene Delegate
extension SceneDelegateDebug {
    
}

// MARK: - Private Methods
private extension SceneDelegateDebug {
    
    func printPathNames() {
        let bundlePath = Bundle.main.bundlePath
        let documentsPath = FileManager
            .default
            .urls(
                for: .documentDirectory,
                in: .userDomainMask)
            .first!
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
        Logger.app.debug("Bundle path: \(bundlePath)")
        Logger.app.debug("Documents path: \(documentsPath)")
    }
    
    func printAvailableFonts() {
        UIFont.familyNames.forEach { familyName in
            Logger.app.debug("\(familyName)")
            UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
                Logger.app.debug("\t\(fontName)")
            }
        }
    }
    
}
