import Testing
import Combine
import Domain
import SharedUtilsTests
@testable import Project

class HeroListViewModelTests {
    
    // MARK: - Properties
    private var viewModel: HeroListViewModel!
    private var render: HeroListRenderMock!
    private var cancellables: Set<AnyCancellable>!
    
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
extension HeroListViewModelTests {
    
    /// GIVEN: A valid local data source with a valid formatted json
    /// WHEN: Calling the use case
    /// THEN: All data should be parsed correctly
    @Test
    func fetchHeroes_success() async {
        // Given
        let dataSource = UseCaseHeroDataSourceMock()
            .withGetHeroes(.success([Hero.sample]))
        viewModel = setupViewModel(dataSource: dataSource)
        
        viewModel
            .$model
            .dropFirst() // Ignore initial state
            .sinkWithValue { model in
                // Then
                #expect(model.heroes.isEmpty)
                #expect(model.heroes.count == 1)
            }
            .store(in: &cancellables)
        
        // When
        viewModel.onReloadData()
    }
    
    /// GIVEN: An invalid local data source (file not found)
    /// WHEN: Calling the use case
    /// THEN: An error should be thrown and no data should be parsed
    @Test
    func fetchHeroes_failure() async {
        // Given
        let dataSource = UseCaseHeroDataSourceMock()
            .withGetHeroes(.failure(NSError(domain: "GetHeroesFailed", code: -1)))
        viewModel = setupViewModel(dataSource: dataSource)

        viewModel
            .$model
            .dropFirst() // Ignore initial state
            .sinkWithValue { model in
                // Then
                #expect(model.heroes.isEmpty)
                #expect(model.heroesFiltered.isEmpty)
            }
            .store(in: &cancellables)
        
        // When
        viewModel.onReloadData()
    }
    
    /// GIVEN: A list of heroes
    /// WHEN: Filtering by something that does NOT match anything
    /// THEN: The list should be empty
    @Test
    func filterHeroes_no_results() async {
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
        // When
        viewModel.model.searchText = "123"
        viewModel.$model
            .dropFirst() // Ignore initial state
            .sinkWithValue { model in
                // Then
                #expect(model.heroesFiltered.isEmpty)
            }
            .store(in: &cancellables)
    }
    
    /// GIVEN: A list of heroes
    /// WHEN: Selecting one of them
    /// THEN: Details should be presented
    @Test
    func onSelectHero() async {
        // Given
        let dataSource = UseCaseHeroDataSourceMock()
            .withGetHeroes(.success([Hero.sample]))
        viewModel = setupViewModel(dataSource: dataSource)
        
        // When
        viewModel.$model
            .dropFirst() // Ignore initial state
            .sinkWithValue { [unowned self] model in
                let hero = model.heroes.first!
                self.viewModel.onSelect(hero: hero)
                // Then
                #expect(self.render.isToDetailsCalled)
            }
            .store(in: &cancellables)
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
