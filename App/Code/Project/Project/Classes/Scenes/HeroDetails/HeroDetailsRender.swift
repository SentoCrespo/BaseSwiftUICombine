import Foundation
import SwiftUI
import Domain

/// Scene constructor with dependencies and View<>ViewModel binding
class HeroDetailsRender: SceneRender {
    
    // MARK: - Properties
    private let configurator: HeroDetailsConfigurator
    private var navigationController: UINavigationController?
    
    // MARK: - Life Cycle
    init(configurator: HeroDetailsConfigurator) {
        self.configurator = configurator
    }
    
}
 
extension HeroDetailsRender {
    
    func view(hero: Hero, navigationController: UINavigationController) -> some View {
        self.navigationController = navigationController
        let viewModel = HeroDetailsViewModel(
            hero: hero,
            render: self,
            configurator: self.configurator
        )
        return HeroDetailsUIView(viewModel: viewModel)
    }
    
}
