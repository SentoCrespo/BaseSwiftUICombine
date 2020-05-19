import Foundation

/// Container with explicit dependencies for the scene
struct MainConfigurator {
    
    // MARK: - Properties
    let datasource: DataSourceConfiguration
    
    // MARK: - Life Cycle
    init(datasource: DataSourceConfiguration) {
        self.datasource = datasource
    }
    
}
