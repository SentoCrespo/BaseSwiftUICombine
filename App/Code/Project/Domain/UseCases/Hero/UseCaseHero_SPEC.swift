import Testing
import Combine
import SharedUtilsTests
@testable import Domain

class UseCaseHero_SPEC {
    
    // MARK: - Properties
    var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Life Cycle
    init() {
        cancellables = []
    }
    
    deinit {
        cancellables = []
    }
    
}

// MARK: - Tests
extension UseCaseHero_SPEC {
    
    /// GIVEN: A valid local data source with a valid formatted json
    /// WHEN: Calling the use case
    /// THEN: All data should be parsed correctly
    @Test
    func fetchHeroes_Success() async {
        // Given
        let dataSource = UseCaseHeroDataSourceLocal(filename: "Heroes")
        
        // When
        let comment: Comment? = "Successfully fetched heroes"
        await confirmation(comment) { confirmation in
            UseCaseHeroes
                .heroes(dataSource: dataSource)
                .sinkWithValue { heroes in
                    // Then
                    #expect(heroes.count == 6)
                    #expect(heroes.first?.name == "Spiderman")
                    confirmation()
                }
                .store(in: &cancellables)
        }
        
    }
    
    /// GIVEN: A valid local data source with an invalid formatted json (name is missing)
    /// WHEN: Calling the use case
    /// THEN: Data parsing should fail
    @Test
    func fetchHeroesDecodingError() async {
        // Given
        let dataSource = UseCaseHeroDataSourceLocal(filename: "Heroes_invalid")
        
        // When
        let comment: Comment? = "Failed to fetch heroes due to decoding error"
        await confirmation(comment) { confirmation in
            UseCaseHeroes
                .heroes(dataSource: dataSource)
                .sinkWithFailure { error in
                    // Then
                    #expect(error is DecodingError, "Expected DecodingError but got \(error)")
                    confirmation()
                }
                .store(in: &cancellables)
        }
        
    }
    
}
