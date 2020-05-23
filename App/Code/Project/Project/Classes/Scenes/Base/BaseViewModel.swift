import Foundation
import Combine

class BaseViewModel<Model: SceneModel>: SceneViewModel {
    
    @Published var output: TransitionOutput
    let stateMachineSystem: StateMachineSystem<Model.State, Model.Event, Model.Effect>
    var disposeBag: Set<AnyCancellable>
    let configurator: SceneConfigurator
    
    required init(configurator: SceneConfigurator) {
        self.configurator = configurator
        
        self.disposeBag = []
        
        // Initialize state machine
        let stateMachine: StateMachine<Model.State, Model.Event, Model.Effect> = StateMachine(
            initialState: Model.initialState,
            transitions: Model.createTransitions()
            )
        self.stateMachineSystem = StateMachineSystem(
            stateMachine: stateMachine
        )
        
        // Publish initial state
        self.output = TransitionOutput(
            from: Model.initialState,
            event: Model.initialEvent,
            to: Model.initialState
        )
        
        // Listen for effects
        self.stateMachineSystem
            .system
            .receive(on: RunLoop.main)
            // Handle effects on every change
            .map { [weak self] (output) -> TransitionOutput in
                if let effect = output.effect {
                    self?.handle(effect: effect)
                }
                return output
            }
            // Propagate the changes to published var
            .assign(to: \.output, on: self)
            .store(in: &disposeBag)
        
    }
    
    deinit {
        self.disposeBag.removeAll()
    }
    
    func handle(effect: Model.Effect) {
        assertionFailure("Implement in subclass")
    }
            
}
