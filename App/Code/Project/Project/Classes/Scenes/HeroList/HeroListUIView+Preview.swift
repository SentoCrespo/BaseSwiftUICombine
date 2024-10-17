import Foundation
import SwiftUI

#if DEBUG
extension HeroListUIView_Previews {
    
    static func createPreview() -> some View {
        let configurator = HeroListConfigurator.default
        let render = HeroListRender(configurator: configurator)
        let viewModel = HeroListViewModel(
            render: render,
            configurator: configurator
        )
        return HeroListUIView(viewModel: viewModel)
    }
    
}
#endif
