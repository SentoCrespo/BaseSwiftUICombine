import XCTest
import Combine
@testable import Project

class UseCaseHero_SPEC: XCTestCase {
    
    // MARK: - Properties
    var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = []
        super.tearDown()
    }
    
}
 
// MARK: - Tests
extension UseCaseHero_SPEC {
    
    /// GIVEN: A valid local data source with a valid formatted json
    /// WHEN: Calling the use case
    /// THEN: All data should be parsed correctly
    func test_FetchHeroes_Success() {
        // Given
        let dataSource = UseCaseHeroDataSourceLocal(filename: "Heroes")
        
        // When
        let expectation = XCTestExpectation(description: "Successfully fetched heroes")
        HeroesUseCase
            .heroes(dataSource: dataSource)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("Expected success but got error: \(error.localizedDescription)")
                    }
                },
                receiveValue: { heroes in
                    // Then
                    XCTAssertEqual(heroes.count, 6, "Expected 6 heroes but got \(heroes.count)")
                    XCTAssertEqual(heroes.first?.name, "Spiderman", "Expected Spiderman to be the first hero")
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.1)
    }
    
    /// GIVEN: A valid local data source with an invalid formatted json (name is missing)
    /// WHEN: Calling the use case
    /// THEN: Data parsing should fail
    func testFetchHeroesDecodingError() {
        // Given
        let dataSource = UseCaseHeroDataSourceLocal(filename: "Heroes_invalid")
        
        // When
        let expectation = XCTestExpectation(description: "Failed to fetch heroes due to decoding error")
        
        HeroesUseCase.heroes(dataSource: dataSource)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    // Then
                    XCTAssertTrue(error is DecodingError, "Expected DecodingError but got \(error)")
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
}
