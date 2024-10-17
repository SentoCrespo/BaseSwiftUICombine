import Foundation
import SwiftUI
import Domain

/// Scene constructor with dependencies and View<>ViewModel binding
struct HeroListRender: SceneRender {
    
    // MARK: - Properties
    private let configurator: HeroListConfigurator
    private var navigationController: UINavigationController?
    
    // MARK: - Life Cycle
    init(configurator: HeroListConfigurator) {
        self.configurator = configurator
    }
    
}
 
extension HeroListRender {
    
    mutating func view(navigationController: UINavigationController) -> some View {
        self.navigationController = navigationController
        let viewModel = HeroListViewModel(
            render: self,
            configurator: self.configurator
        )
        return HeroListUIView(viewModel: viewModel)
    }
    
    func toDetails(hero: Hero) {
//        let configurator = AnotherConfigurator.default
//        var render = AnotherRender(configurator: configurator)
//        let view = render
//            .view(
//                navigationController: self.navigationController
//            )
//        
//        self.navigationController?
//            .pushViewController(
//                UIHostingController(rootView: view),
//                animated: true
//            )
    }
    
}
