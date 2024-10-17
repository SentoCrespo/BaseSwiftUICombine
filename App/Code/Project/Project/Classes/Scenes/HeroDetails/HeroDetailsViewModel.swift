import Foundation
import Combine
import Domain

/// Binding between UI and business logic
class HeroDetailsViewModel: ObservableObject {
    
    // MARK: - Properties
    private let render: HeroDetailsRender
    private let configurator: HeroDetailsConfigurator
    private var cancellables: Set<AnyCancellable>
    @Published var model: HeroDetailsModel
    
    // MARK: - Life Cycle
    init(hero: Hero, render: HeroDetailsRender, configurator: HeroDetailsConfigurator) {
        self.render = render
        self.configurator = configurator
        self.cancellables = []
        
        self.model = HeroDetailsModel(hero: hero)
    }
    
    deinit {
        cancellables.removeAll()
    }
    
}

// MARK: - Public Methods
extension HeroListViewModel {}

// MARK: - Private Methods
private extension HeroListViewModel {}
