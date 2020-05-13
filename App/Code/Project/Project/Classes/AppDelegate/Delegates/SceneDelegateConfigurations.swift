import Foundation
import UIKit
import Domain
import PlatformNetworkApi
import WUEnvironment

/// Perform data configurations, e.g. datasource, persistence, ...
class SceneDelegateConfigurations: SceneDelegateType {
    
    // MARK: - Properties
    var apiEnvironment: ApiEnvironment!
    var dataSourceConfiguration: DataSourceConfiguration!
    
    // MARK: - Life Cycle
    
}

// MARK: - App Delegate
extension SceneDelegateConfigurations {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        self.initApiEnvironment()
        self.initDatasourceConfiguration()
        
        return true
    }
    
}

// MARK: - Scene Delegate
extension SceneDelegateConfigurations {
    // TODO:
}

// MARK: - Private Methods
private extension SceneDelegateConfigurations {
    
    func initApiEnvironment() {
        if WUManagerEnvironment.isDebugFlag {
            self.apiEnvironment = .integration
        } else if WUManagerEnvironment.isAdhocFlag {
            self.apiEnvironment = .demo
        } else if WUManagerEnvironment.isReleaseFlag {
            self.apiEnvironment = .production
        } else {
            self.apiEnvironment = .production
        }
    }
    
    func initDatasourceConfiguration() {
        self.dataSourceConfiguration = DataSourceConfiguration()
    }
    
}
