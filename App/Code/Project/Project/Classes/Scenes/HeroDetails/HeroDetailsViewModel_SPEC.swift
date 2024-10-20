import XCTest
import Combine
import Domain
@testable import Project

class HeroDetailsViewModelTests: XCTestCase {

    // MARK: - Properties
    private var viewModel: HeroDetailsViewModel!
    private var cancellables: Set<AnyCancellable>!
    private let timeout: TimeInterval = 0.1
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        viewModel = nil
        
        super.tearDown()
    }

}

// MARK: - Tests
extension HeroDetailsViewModelTests {
    
    /// GIVEN: A hero
    /// WHEN: Presenting the view
    /// THEN: Data should be shown correctly
    func test_displayHero_success() {
        // Given
        let hero = Hero.sample
        viewModel = setupViewModel(hero: hero)

        let expectation = XCTestExpectation(description: "Fetch heroes successfully")

        // When
        viewModel.$model
            .sink { model in
                // Then
                XCTAssertNotNil(model.hero)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: timeout)
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
