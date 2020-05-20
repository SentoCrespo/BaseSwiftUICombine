@testable import Project
import Foundation
import XCTest
import Combine

class MainViewModelTests: BaseTest {
    
    // MARK: - Properties
    private var configurator: MainConfigurator?
    private var render: MainSceneRender?
    private var view: MainUIView?
    private var viewModel: MainViewModel?
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        
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
        let configurator = MainViewModelTests.mockConfigurator
        let viewModel = MainViewModel(configurator: configurator)
        
        // When
        /// Initial state
        XCTAssertEqual(viewModel.output.to, .idle)
        
        // Transition with 'none'
        let output1 = viewModel.applyBlocking(event: .none)
        XCTAssertEqual(output1.to, .idle)
        
        // Transition with ''
        let output2 = viewModel.applyBlocking(event: .onAppear)
        XCTAssertEqual(output2.to, .loading)
        
        // Then
        XCTAssert(true)
    }
    
}

private extension MainViewModel {
 
    func applyBlocking(event: MainViewModel.Event) -> MainViewModel.TransitionOutput {
        self.apply(event: event)
        // Run one cycle to get the output as it's asynchronous
        RunLoop.main.run(mode: .default, before: .distantPast)
        return self.output
    }
    
}

// MARK: - Private
import PlatformNetworkStatic
private extension MainViewModelTests {
    
    static var mockConfigurator: MainConfigurator {
        let responseType: ResponseType = .success(code: 200)
        return self.configurator(responseType: responseType)
    }
    
    static func configurator(responseType: ResponseType) -> MainConfigurator {
        let datasource = DataSourceConfiguration()
        let configurator = MainConfigurator(datasource: datasource)
        return configurator
    }
    
    func setupScene(configurator: MainConfigurator) {
        self.configurator = configurator
        self.render = MainSceneRender(configurator: configurator)
        _ = self.render?.view()
    }
    
}
