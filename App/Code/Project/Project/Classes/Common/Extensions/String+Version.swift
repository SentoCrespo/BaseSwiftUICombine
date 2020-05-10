import Foundation
import PRSharedUtils

extension String {
    static var version: String {
        let result = "v. \(Bundle.main.versionNumber!) (\(Bundle.main.buildNumber!))"
        return result
    }
    
    static var versionForUpdates: String {
        return Bundle.main.versionNumber!
    }
}
