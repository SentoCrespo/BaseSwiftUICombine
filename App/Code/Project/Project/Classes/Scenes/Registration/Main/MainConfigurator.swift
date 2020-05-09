import Foundation

// MARK: - Configurator

struct MainConfigurator {
    let dataSource: DataSourceConfiguration
    
    init(dataSource: DataSourceConfiguration) {
        self.dataSource = dataSource
    }
}
