// swiftlint:disable line_length
import Foundation
import UIKit

/// Handle Deeplinks
class SceneDelegateDeeplinks: SceneDelegateType {
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
}

// MARK: - App Delegate
extension SceneDelegateDeeplinks {
    
}

// MARK: - Scene Delegate
extension SceneDelegateConfigurations {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Handle deep link if applicable
        if let userActivity = connectionOptions
            .userActivities
            .first(where: {
                return $0.activityType == NSUserActivityTypeBrowsingWeb
                
            }),
            let webpageURL = userActivity.webpageURL {
            Logger.navigation.debug("Deeplink: \(webpageURL.absoluteString)")
            // Handle Deeplink
        }
        
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb else {
            return
        }
        guard let webpageURL = userActivity.webpageURL else {
            return
        }
        Logger.navigation.debug("Deeplink: \(webpageURL.absoluteString)")
        // Handle Deeplink
    }
    
}

// MARK: - Private Methods
private extension SceneDelegateConfigurations {
    
}
