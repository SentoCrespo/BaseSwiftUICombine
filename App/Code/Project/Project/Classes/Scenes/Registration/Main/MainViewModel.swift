import Foundation
import Combine

class MainViewModel: ObservableObject {

    // MARK: - Typealias
    typealias State = MainModel.State
    typealias Event = MainModel.Event
    typealias Effect = MainModel.Effect
    
    // MARK: - Properties
    /// State that will be observed by the view
    @Published private(set) var stateMachineSystem: StateMachineSystem<State, Event, Effect>
    
    /// Disposable bag
    private var bag: Set<AnyCancellable>
//    private let configurator: MainConfigurator
    
    // MARK: - Life Cycle
    // TODO: Inject properties Configurator
    init() {
//        self.configurator = configurator
        
        // Initial values
        self.bag = []
        
        self.stateMachineSystem = StateMachineSystem(
            stateMachine: StateMachine(
                initialState: .idle,
                transitions: MainModel.createTransitions()
            )
        )
        
        // Listen for effects
        self.stateMachineSystem
            .system
            .receive(on: RunLoop.main)
            // .assign(to: \.stateMachine, on: self)
            .sink(receiveValue: { [weak self] stateMachineOutput in
                guard let effect = stateMachineOutput.effect else {
                    return
                }
                self?.handleEffect(effect)
            })
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
    
    func handleEffect(_ effect: Effect) {
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
