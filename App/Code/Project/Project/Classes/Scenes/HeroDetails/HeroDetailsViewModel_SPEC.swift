import Testing
import Combine
import Domain
@testable import Project

class HeroDetailsViewModelTests {

    // MARK: - Properties
    private var viewModel: HeroDetailsViewModel!
    private var cancellables: Set<AnyCancellable>!
    private let timeout: TimeInterval = 0.1
    
    // MARK: - Life Cycle
    init() {
        cancellables = []
    }

    deinit {
        cancellables = nil
        viewModel = nil
    }

}

// MARK: - Tests
extension HeroDetailsViewModelTests {
    
    /// GIVEN: A hero
    /// WHEN: Presenting the view
    /// THEN: Data should be shown correctly
    @Test
    func displayHero_success() async {
        // Given
        let hero = Hero.sample
        viewModel = setupViewModel(hero: hero)
        let comment: Comment? = "Successfully fetched heroes"
        await confirmation(comment) { confirmation in
            // When
            viewModel
                .$model
                .sink(receiveValue: { model in
                    // Then
                    #expect(model.hero != nil)
                    confirmation()
                })
                .store(in: &cancellables)
        }
    }
    
}

// MARK: - Private Methods
private extension HeroDetailsViewModelTests {
    
    func setupViewModel(hero: Hero) -> HeroDetailsViewModel {
        let configurator = HeroDetailsConfigurator(
            mainStore: AppReduxStore.mock()
        )
        let viewModel = HeroDetailsViewModel(
            hero: hero,
            render: HeroDetailsRenderMock(configurator: configurator),
            configurator: configurator
        )
        return viewModel
    }
    
}
