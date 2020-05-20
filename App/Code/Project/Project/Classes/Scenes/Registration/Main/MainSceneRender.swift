import Foundation
import SwiftUI

/// Scene constructor with dependencies and View<>ViewModel binding
struct MainSceneRender {
    
    // MARK: - Properties
    private let configurator: MainConfigurator
    
    // MARK: - Life Cycle
    init(configurator: MainConfigurator) {
        self.configurator = configurator
    }
    
}
 
extension MainSceneRender {
     
    func view() -> some View {
        let viewModel = MainViewModel(configurator: self.configurator)
        return MainUIView(render: self, viewModel: viewModel)
    }
    
}
