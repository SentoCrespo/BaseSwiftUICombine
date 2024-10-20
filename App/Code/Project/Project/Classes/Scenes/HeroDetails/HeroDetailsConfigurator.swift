import Foundation
import Domain

/// Container with explicit dependencies for the scene
struct HeroDetailsConfigurator: SceneConfigurator {
    
    // MARK: - Properties
    let mainStore: AppReduxStore
    
    // MARK: - Life Cycle
    // Default constructor
    
}

extension HeroDetailsConfigurator {
    
    static var `default`: HeroDetailsConfigurator {
        let result = HeroDetailsConfigurator(
            mainStore: Application.shared.store
        )
        return result
    }
    
}
