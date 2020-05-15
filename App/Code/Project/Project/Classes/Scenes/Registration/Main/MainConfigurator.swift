import Foundation

// MARK: - Configurator
struct MainConfigurator {
    
    // MARK: - Properties
    let dataSource: DataSourceConfiguration
    
    // MARK: - Life Cycle
    init(dataSource: DataSourceConfiguration) {
        self.dataSource = dataSource
    }
    
}
