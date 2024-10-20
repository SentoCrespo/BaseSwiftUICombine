import XCTest
import Combine
import Domain
@testable import Project

class HeroListViewModelTests: XCTestCase {
    
    // MARK: - Properties
    private var viewModel: HeroListViewModel!
    private var render: HeroListRenderMock!
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
    
    
    /// GIVEN: A list of heroes
    /// WHEN: Filtering by something that does NOT match anything
    /// THEN: The list should be empty
    func test_filterHeroes_no_results() {
        // Given
        let dataSource = UseCaseHeroDataSourceMock()
            .withGetHeroes(.success([]))
        viewModel = setupViewModel(dataSource: dataSource)
        var hero1 = Hero.sample
        hero1.name = "Spiderman"
        var hero2 = Hero.sample
        hero2.name = "Batman"
        viewModel.model.heroes = [
            hero1,
            hero2
        ]
        let expectation = XCTestExpectation(description: "Filter heroes no results")
        
        // When
        viewModel.model.searchText = "123"
        viewModel.$model
            .dropFirst() // Ignore initial state
            .sink { model in
                // Then
                XCTAssertTrue(model.heroesFiltered.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: timeout)
    }
    
    /// GIVEN: A list of heroes
    /// WHEN: Selecting one of them
    /// THEN: Details should be presented
    func test_onSelectHero() {
        // Given
        let dataSource = UseCaseHeroDataSourceMock()
            .withGetHeroes(.success([Hero.sample]))
        viewModel = setupViewModel(dataSource: dataSource)
        let expectation = XCTestExpectation(description: "Select hero")
        
        // When
        viewModel.$model
            .dropFirst() // Ignore initial state
            .sink { [unowned self] model in
                let hero = model.heroes.first!
                self.viewModel.onSelect(hero: hero)
                // Then
                XCTAssertTrue(self.render.isToDetailsCalled)
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
        render = HeroListRenderMock(configurator: configurator)
        let viewModel = HeroListViewModel(
            render: render,
            configurator: configurator
        )
        return viewModel
    }
    
}
