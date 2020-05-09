import Foundation

// MARK: - Configurator

struct SignupConfigurator {
    let dataSource: DataSourceConfiguration
    
    init(dataSource: DataSourceConfiguration) {
        self.dataSource = dataSource
    }
}
