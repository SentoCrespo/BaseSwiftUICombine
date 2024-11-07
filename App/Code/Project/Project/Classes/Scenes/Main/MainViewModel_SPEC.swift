@testable import Project
import Foundation
import Testing
import Combine
import SwiftUI

class MainViewModelTests {
    
    // MARK: - Properties
    private var store: AppReduxStore?
    private var configurator: MainConfigurator?
    private var render: MainRender?
    private var view: MainUIView?
    private var viewModel: MainViewModel?
    
    // MARK: - Life Cycle
    init() {
        let store = AppReduxStore.mock()
        self.store = store
        let configurator = MainConfigurator(mainStore: store)
        self.setupScene(configurator: configurator)
    }
    
    deinit {
        self.configurator = nil
        self.render = nil
        self.view = nil
        self.viewModel = nil
    }
    
}

// MARK: - Tests
extension MainViewModelTests {
    
    @Test(
        .disabled("Generated state machine doesn't need to be tested")
    )
    func stateMachine_Transitions() {
        // Given
        let viewModel = self.viewModel!
        
        // When
        // Initial state
        #expect(viewModel.output.to == .idle)
        
        // Transition with 'none'
        let output1 = viewModel.applyBlocking(event: .start)
        #expect(output1.to == .idle)
        
        // Transition with 'onAppear'
        let output2 = viewModel.applyBlocking(event: .onAppear)
        #expect(output2.to == .loading)
        
        // Transition with 'onLoadingSuccess'
        let resultOnLoad = "Result"
        let output3 = viewModel.applyBlocking(event: .onLoadingSuccess(resultOnLoad))
        #expect(output3.to == .loaded)
        
        // Transition with 'onSelect'
        let resultOnSuccess = "Select"
        let output4 = viewModel.applyBlocking(event: .onSelect(resultOnSuccess))
        #expect(output4.to == .loaded)
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
