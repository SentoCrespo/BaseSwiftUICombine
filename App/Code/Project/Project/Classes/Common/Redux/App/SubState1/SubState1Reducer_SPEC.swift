import Foundation
import XCTest

@testable import Project

final class SubState1ReducerTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
}

extension SubState1ReducerTests {
    
    /// GIVEN:
    ///  -
    /// WHEN:
    ///  -
    ///  THEN:
    ///  -
    func test_sample() {
        
        // Given
        let store: AppReduxStore = .init(
            initialState: .initial,
            reducer: AppReducer.reducer,
            middlewares: []
        )
        let newValue: String = "asd"
        
        // When
        let action = SubState1Action.myAction
        store.dispatch(action)
        
        // Then
        XCTAssertEqual(
            store.state.subState1.myGlobalVar, "newValue")
    }
    
}
