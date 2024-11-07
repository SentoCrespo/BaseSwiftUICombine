import Foundation
import Combine
import Domain

/// Binding between UI and business logic
class HeroListViewModel: ObservableObject {
    
    // MARK: - Properties
    private let render: HeroListRender
    private let configurator: HeroListConfigurator
    private var cancellables: Set<AnyCancellable>
    @Published var model: HeroListModel
    
    // MARK: - Life Cycle
    init(render: HeroListRender, configurator: HeroListConfigurator) {
        self.render = render
        self.configurator = configurator
        self.cancellables = []
        
        self.model = HeroListModel()
        self.setupBindings()
        self.fetchHeroes()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
}

// MARK: - Public Methods
extension HeroListViewModel {

    func onReloadData() {
        fetchHeroes()
    }
    
    func onSelect(hero: Hero) {
        render.toDetails(hero: hero)
    }
    
}

// MARK: - Private Methods
private extension HeroListViewModel {
    
    func setupBindings() {
        // Filter heroes when the search text changes
        $model
            .map(\.searchText)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] searchTerm in
                self?.filterHeroes(searchTerm: searchTerm)
            }
            .store(in: &cancellables)
    }
    
    func fetchHeroes() {
        UseCaseHeroes
            .heroes(dataSource: configurator.heroDataSource)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Error fetching heroes: \(error)")
                    }
                },
                receiveValue: { [weak self] heroes in
                    self?.model.heroes = heroes
                    self?.model.heroesFiltered = heroes
                }
            )
            .store(in: &cancellables)
    }
    
    func filterHeroes(searchTerm: String) {
        if searchTerm.isEmpty {
            model.heroesFiltered = model.heroes
        } else {
            model.heroesFiltered = model.heroes.filter { hero in
                hero.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
}
