import Foundation
import UIKit

class DeepLinksManager {
    
    static func process(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
                        window: UIWindow?) -> Bool {
        guard let url = launchOptions?[UIApplication.LaunchOptionsKey.url] as? URL else {
            Log.debug("No Url found")
            return false
        }
        return process(url: url, window: window)
    }
    
    static func process(url: URL, window: UIWindow?) -> Bool {
        guard window != nil else {
            Log.error("No window found")
            return false
        }
        Log.debug("Deep Link Parsing: \(url.absoluteString)")
        // Process here deeplinks
        return true
    }
}

private extension DeepLinksManager {}
