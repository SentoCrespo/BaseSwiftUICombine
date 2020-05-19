import Foundation
import Combine

/// Binding between UI and business logic
class MainViewModel: ObservableObject {

    // MARK: - Typealias
    typealias State = MainModel.State
    typealias Event = MainModel.Event
    typealias Effect = MainModel.Effect
    typealias TransitionOutput = TransitionResult<State, Event, Effect>
    
    // MARK: - Published Properties
    /// State transitions that will be observed by the view
    @Published var output: TransitionOutput
    
    // MARK: - Properties
    /// State machine
    let initialState: State = .idle
    private var stateMachineSystem: StateMachineSystem<State, Event, Effect>
    /// Disposable bag
    private var bag: Set<AnyCancellable> = []
    private let configurator: MainConfigurator
    
    // MARK: - Life Cycle
    init(configurator: MainConfigurator) {
        self.configurator = configurator
        
        // Initial values
        self.stateMachineSystem = StateMachineSystem(
            stateMachine: StateMachine(
                initialState: initialState,
                transitions: MainModel.createTransitions()
            )
        )
        
        // Publish initial state
        self.output = TransitionOutput(
            from: initialState,
            event: .none,
            to: initialState
        )
        
        // Listen for effects
        self.stateMachineSystem
            .system
            .receive(on: RunLoop.main)
            // Handle effects on every change
            .map { [weak self] output -> TransitionOutput in
                if let effect = output.effect {
                    self?.handle(effect: effect)
                }
                return output
            }
            // Propagate the changes to published var
            .assign(to: \.output, on: self)
            .store(in: &bag)
        
    }
    
    deinit {
        self.bag.removeAll()
    }
    
}

// MARK: - Events handling
extension MainViewModel {
    
    /// Method to publish incoming actions from the view
    func apply(event: Event) {
        self.stateMachineSystem.apply(event: event)
    }
    
}

// MARK: - Effects handling
extension MainViewModel {
    
    func handle(effect: Effect) {
        Log.debug("Processing effect: \(effect)")
        switch effect {
        case .loadItems:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.apply(event: .onLoadingSuccess(["Result"]))
            }
        case .navigateToProfile:
            Log.debug("Navigate to profile effect")
        }
    }
    
}
