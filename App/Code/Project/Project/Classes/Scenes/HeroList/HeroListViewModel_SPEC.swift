import XCTest
import Combine
import Domain
@testable import Project

class HeroListViewModelTests: XCTestCase {
    
    // MARK: - Properties
    private var viewModel: HeroListViewModel!
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
extension HeroListViewModelTests {
    
    /// GIVEN: A valid local data source with a valid formatted json
    /// WHEN: Calling the use case
    /// THEN: All data should be parsed correctly
    func test_fetchHeroes_success() {
        // Given
        let dataSource = UseCaseHeroDataSourceMock()
            .withGetHeroes(.success([Hero.sample]))
        viewModel = setupViewModel(dataSource: dataSource)

        let expectation = XCTestExpectation(description: "Fetch heroes successfully")

        // When
        viewModel.$model
            .dropFirst() // Ignore initial state
            .sink { model in
                // Then
                XCTAssertFalse(model.heroes.isEmpty)
                XCTAssertEqual(model.heroes.count, 1)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: timeout)
    }

    /// GIVEN: An invalid local data source (file not found)
    /// WHEN: Calling the use case
    /// THEN: An error should be thrown and no data should be parsed
    func test_fetchHeroes_failure() {
        // Given
        let dataSource = UseCaseHeroDataSourceMock()
            .withGetHeroes(.failure(NSError(domain: "GetHeroesFailed", code: -1)))
        viewModel = setupViewModel(dataSource: dataSource)

        let expectation = XCTestExpectation(description: "Fail to fetch heroes")

        // When
        viewModel.$model
            .sink { model in
                // Then
                XCTAssertTrue(model.heroes.isEmpty)
                XCTAssertTrue(model.heroesFiltered.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: timeout)
    }
}

// MARK: - Private Methods
private extension HeroListViewModelTests {
    
    func setupViewModel(dataSource: UseCaseHeroDataSourceMock) -> HeroListViewModel {
        let configurator = HeroListConfigurator(
            mainStore: AppReduxStore.mock(),
            heroDataSource: dataSource
        )
        let viewModel = HeroListViewModel(
            render: HeroListRenderMock(configurator: configurator),
            configurator: configurator
        )
        return viewModel
    }
    
}
