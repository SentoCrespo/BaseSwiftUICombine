import Foundation
import SwiftUI

/// The composer used to construct views for the scene.
protocol RenderType {}

/// Scene constructor with dependencies and View<>ViewModel binding
struct MainSceneRender: RenderType {
    
    // MARK: - Properties
    private let configurator: MainConfigurator
    
    // MARK: - Life Cycle
    init(configurator: MainConfigurator) {
        self.configurator = configurator
    }
    
}
 
extension MainSceneRender {
     
    func view() -> some View {
        MainUIView()
    }
}
