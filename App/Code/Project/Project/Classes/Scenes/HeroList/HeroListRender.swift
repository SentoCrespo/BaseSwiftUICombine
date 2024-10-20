import Foundation
import SwiftUI
import Domain

/// Scene constructor with dependencies and View<>ViewModel binding
class HeroListRender: SceneRender {
    
    // MARK: - Properties
    private let configurator: HeroListConfigurator
    private var navigationController: UINavigationController?
    
    // MARK: - Life Cycle
    init(configurator: HeroListConfigurator) {
        self.configurator = configurator
    }

    func view(navigationController: UINavigationController) -> some View {
        self.navigationController = navigationController
        let viewModel = HeroListViewModel(
            render: self,
            configurator: self.configurator
        )
        return HeroListUIView(viewModel: viewModel)
    }
    
    func toDetails(hero: Hero) {
        let configurator = HeroDetailsConfigurator.default
        var render = HeroDetailsRender(configurator: configurator)
        guard let navigationController = self.navigationController else {
            print("Navigation controller is not available")
            return
        }
        let view = render.view(hero: hero, navigationController: navigationController)
        
        self.navigationController?.pushViewController(
            UIHostingController(rootView: view),
            animated: true
        )
    }
    
}
