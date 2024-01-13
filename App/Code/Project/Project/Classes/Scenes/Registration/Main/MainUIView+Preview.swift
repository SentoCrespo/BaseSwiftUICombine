import Foundation
import SwiftUI

#if DEBUG
extension MainUIView_Previews {
    
    static func createPreview() -> some View {
        let configurator = MainConfigurator.default
        let render = MainRender(configurator: configurator)
        let viewModel = MainViewModel(
            render: render,
            configurator: configurator
        )
        return MainUIView(viewModel: viewModel)
    }
    
}
#endif
