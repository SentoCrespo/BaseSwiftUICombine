import Foundation
import SwiftUI

/// Scene constructor with dependencies and View<>ViewModel binding
struct MainRender: SceneRender {
    
    // MARK: - Properties
    private let configurator: MainConfigurator
    private var navigationController: UINavigationController?
    
    // MARK: - Life Cycle
    init(configurator: MainConfigurator) {
        self.configurator = configurator
    }
    
}
 
extension MainRender {
    
    mutating func view(navigationController: UINavigationController) -> some View {
        self.navigationController = navigationController
        let viewModel = MainViewModel(
            render: self,
            configurator: self.configurator
        )
        return MainUIView(viewModel: viewModel)
    }
    
    //        func toAnotherView() {
    //            let configurator = AnotherConfigurator.default
    //            var render = AnotherRender(configurator: configurator)
    //            let view = render
    //                .view(
    //                    navigationController: self.navigationController
    //                )
    //
    //            self.navigationController?
    //                .pushViewController(
    //                    UIHostingController(rootView: view),
    //                    animated: true
    //                )
    //        }
    
}
