import Foundation
import SwiftUI
import Domain

#if DEBUG
#Preview("HeroDetailsUIView") {
    HeroDetailsUIView.createPreview()
}

private extension HeroDetailsUIView {
    
    static func createPreview() -> some View {
        let configurator = HeroDetailsConfigurator.default
        let render = HeroDetailsRender(configurator: configurator)
        let hero = Hero.sample
        let viewModel = HeroDetailsViewModel(
            hero: hero,
            render: render,
            configurator: configurator
        )
        return HeroDetailsUIView(viewModel: viewModel)
    }
    
}
#endif
