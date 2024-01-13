@testable import Project
import Foundation
import XCTest
import Combine

class MainViewModelTests: BaseTest {
    
    // MARK: - Properties
    private var store: AppReduxStore?
    private var configurator: MainConfigurator?
    private var render: MainRender?
    private var view: MainUIView?
    private var viewModel: MainViewModel?
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        
        let store = AppReduxStore.mock()
        self.store = store
        let configurator = MainConfigurator(mainStore: store)
        self.setupScene(configurator: configurator)
    }
    
    override func tearDown() {
        self.configurator = nil
        self.render = nil
        self.view = nil
        self.viewModel = nil
        
        super.tearDown()
    }
    
}

// MARK: - Tests
extension MainViewModelTests {
    
    func test_stateMachine_Transitions() {
        // Given
        let viewModel = self.viewModel!
        
        // When
        // Initial state
        XCTAssertEqual(viewModel.output.to, .idle)
        
        // Transition with 'none'
        let output1 = viewModel.applyBlocking(event: .start)
        XCTAssertEqual(output1.to, .idle)
        
        // Transition with 'onAppear'
        let output2 = viewModel.applyBlocking(event: .onAppear)
        XCTAssertEqual(output2.to, .loading)
        
        // Transition with 'onLoadingSuccess'
        let resultOnLoad = "Result"
        let output3 = viewModel.applyBlocking(event: .onLoadingSuccess(resultOnLoad))
        XCTAssertEqual(output3.to, .loaded)
        
        // Transition with 'onSelect'
        let resultOnSuccess = "Select"
        let output4 = viewModel.applyBlocking(event: .onSelect(resultOnSuccess))
        XCTAssertEqual(output4.to, .loaded)
        
        // Then
        XCTAssert(true)
    }
    
}

// MARK: - Private
private extension MainViewModelTests {
    
    func setupScene(configurator: MainConfigurator) {
        self.configurator = configurator
        self.render = MainRender(configurator: configurator)
        let navigationController = UINavigationController()
        self.view = self.render?.view(navigationController: navigationController) as? MainUIView
        self.viewModel = self.view?.viewModel
    }
    
}
