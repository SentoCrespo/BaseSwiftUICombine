import Foundation
import Combine

class BaseViewModel<Configurator: SceneConfigurator, Model: SceneModel, Render: SceneRender>: SceneViewModel {
    
    @Published var output: TransitionOutput
    let stateMachineSystem: StateMachineSystem<Model.State, Model.Event, Model.Effect>
    var disposeBag: Set<AnyCancellable>
    let render: SceneRender
    var configurator: SceneConfigurator
    
    required init(render: Render, configurator: Configurator) {
        self.render = render
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
            // Handle events on every change
            .map { [weak self] (output) -> TransitionOutput in
                self?.handle(event: output.event)
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
    
    func handle(event: Model.Event) {
        assertionFailure("Implement in subclass")
    }
            
}
