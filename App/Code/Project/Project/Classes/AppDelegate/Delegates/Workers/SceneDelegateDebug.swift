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
    // TODO:
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
        let components = [
            "",
            "*****************************************",
            "BUNDLE path:",
            "\(bundlePath)",
            "DOCUMENTS path: ",
            "\(documentsPath)",
            "*****************************************"
        ]
        let debugInfo = components.joined(separator: "\n")
        Log.debug(debugInfo)
    }
    
    func printAvailableFonts() {
        UIFont.familyNames.forEach { familyName in
            Log.debug(familyName)
            
            UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
                Log.debug("\tFont: \(fontName)")
            }
        }
    }
    
}
