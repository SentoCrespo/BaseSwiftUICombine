import Foundation

/// Container with explicit dependencies for the scene
struct MainConfigurator: SceneConfigurator {
    
    // MARK: - Properties
    let mainStore: AppReduxStore
    
    // MARK: - Life Cycle
    init(mainStore: AppReduxStore) {
        self.mainStore = mainStore
    }
    
}

extension MainConfigurator {
    
    static var `default`: MainConfigurator {
        let result = MainConfigurator(
            mainStore: Application.shared.store
        )
        return result
    }
    
}
