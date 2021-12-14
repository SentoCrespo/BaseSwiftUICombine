import Domain
import Foundation
import UseCases

/// Possibilities for different datasource types
struct DataSourceConfiguration {
    
    // MARK: Properties
    var user: UseCases.UserDataSource
    
    // MARK: Life Cycle
    init() {
        self.user = DataSourceConfiguration.userStatic(
            responseType: .success(code: 200),
            delay: .milliseconds(500)
        )
    }
}
