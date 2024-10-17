import Foundation
import Domain

/// Container with explicit dependencies for the scene
struct HeroListConfigurator: SceneConfigurator {
    
    // MARK: - Properties
    let mainStore: AppReduxStore
    let heroDataSource: UseCaseHeroDataSource
    
    // MARK: - Life Cycle
    // Default constructor
    
}

extension HeroListConfigurator {
    
    static var `default`: HeroListConfigurator {
        let result = HeroListConfigurator(
            mainStore: Application.shared.store,
            heroDataSource: UseCaseHeroDataSourceLocal(filename: "Heroes")
        )
        return result
    }
    
}
