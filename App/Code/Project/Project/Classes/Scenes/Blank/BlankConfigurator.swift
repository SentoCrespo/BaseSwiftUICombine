import Foundation

// MARK: - Configurator

struct BlankConfigurator {
    let dataSource: DataSourceConfiguration
    
    init(dataSource: DataSourceConfiguration) {
        self.dataSource = dataSource
    }
}
