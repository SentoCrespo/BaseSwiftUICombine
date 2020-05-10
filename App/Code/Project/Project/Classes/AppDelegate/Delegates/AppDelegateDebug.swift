import Foundation

/// Performs debugging info
class AppDelegateDebug: AppDelegateType {

    // MARK: - Properties
    
    // MARK: - Life Cycle
    
}

extension AppDelegateDebug {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        // self.printAvailableFonts()
        self.printPathNames()
        
        return true
    }
    
}

import PRSharedUtils
private extension AppDelegateDebug {
    
    func printPathNames() {
        let bundlePath = Bundle.main.bundlePath
        let documentsPath = PathUtils
            .documentsUrl()!
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
    

            
            
