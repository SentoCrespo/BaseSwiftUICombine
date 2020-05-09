import Domain
import Foundation

/// Possibilities for different datasource types
struct DataSourceConfiguration {
    
    // MARK: Properties
    var user: Domain.UseCasesUsersDataSource
    
    // MARK: Life Cycle
    init() {
        self.user = DataSourceConfiguration.userStatic(
            responseType: .success(code: 200),
            delay: .milliseconds(500)
        )
    }
}
