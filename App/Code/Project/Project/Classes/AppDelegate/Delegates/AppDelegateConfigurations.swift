import Foundation
import UIKit
import Domain
import PlatformNetworkApi
import WUEnvironment

/// Perform data configurations, e.g. datasource, persistence, ...
class AppDelegateConfigurations: AppDelegateType {
    
    // MARK: - Properties
    var apiEnvironment: ApiEnvironment!
    var dataSourceConfiguration: DataSourceConfiguration!
    
    // MARK: - Life Cycle
    
}

extension AppDelegateConfigurations {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        self.initApiEnvironment()
        self.initDatasourceConfiguration()
        
        return true
    }
    
}

private extension AppDelegateConfigurations {
    
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
