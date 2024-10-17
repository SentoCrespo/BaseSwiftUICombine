import XCTest
import Combine
@testable import Project

class HeroListViewModelTests: XCTestCase {

    private var viewModel: HeroListViewModel!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        viewModel = nil
        super.tearDown()
    }

    /// GIVEN: A valid local data source with a valid formatted json
    /// WHEN: Calling the use case
    /// THEN: All data should be parsed correctly
    func test_fetchHeroes_success() {
        // Given: Un datasource local válido
        let dataSource = MockUseCaseHeroDataSourceLocal(success: true)
        let configurator = HeroListConfigurator(mainStore: MockStore(), heroDataSource: dataSource)
        viewModel = HeroListViewModel(render: MockRender(), configurator: configurator)

        let expectation = XCTestExpectation(description: "Fetch heroes successfully")

        // When: Llamamos al caso de uso
        viewModel.$model
            .dropFirst() // Ignoramos el estado inicial
            .sink { model in
                // Then: Los datos deben estar correctamente parseados
                XCTAssertFalse(model.heroes.isEmpty)
                XCTAssertEqual(model.heroes.count, 6)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

    /// GIVEN: An invalid local data source (file not found)
    /// WHEN: Calling the use case
    /// THEN: An error should be thrown and no data should be parsed
    func test_fetchHeroes_failure() {
        // Given: Un datasource local inválido (fichero no encontrado)
        let dataSource = MockUseCaseHeroDataSourceLocal(success: false)
        let configurator = HeroListConfigurator(mainStore: MockStore(), heroDataSource: dataSource)
        viewModel = HeroListViewModel(render: MockRender(), configurator: configurator)

        let expectation = XCTestExpectation(description: "Fail to fetch heroes")

        // When: Llamamos al caso de uso
        viewModel.$model
            .dropFirst() // Ignoramos el estado inicial
            .sink { model in
                // Then: No deben haber datos y se espera un fallo
                XCTAssertTrue(model.heroes.isEmpty)
                XCTAssertTrue(model.heroesFiltered.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
}

// Mock para el configurador
class MockUseCaseHeroDataSourceLocal: UseCaseHeroDataSource {
    private let success: Bool
    
    init(success: Bool) {
        self.success = success
    }

    func getHeroes() -> AnyPublisher<[Hero], Error> {
        if success {
            let heroes = [Hero(name: "Spiderman", realName: "Peter Parker", ...)] // Añade héroes mock
            return Just(heroes)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "File not found", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
    }
}

// Mock para la Render
class MockRender: HeroListRender {
    func toDetails(hero: Hero) {
        // No hace nada, solo para test
    }
}

// Mock para Store
class MockStore: AppReduxStore {
    // Configura tu MockStore si es necesario
}
