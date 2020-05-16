import Foundation
import Combine

class MainViewModel: ObservableObject {

    // MARK: - Typealias
    typealias State = MainModel.State
    typealias Event = MainModel.Event
    typealias Effect = MainModel.Effect
    
    // MARK: - Properties
    /// State that will be observed by the view
    @Published private(set) var stateMachine: StateMachineSystem<State, Event, Effect>
    
    /*
     Maquina de estados se define como estados + transiciones
     Estado inicial
     Transición es (estado actual + event) -> (nextState, effect?)
     Efectos son generados por eventos opcionalmente
     
     Sistema:
     Maquina de estados
     Recibe eventos => Puede disparar efectos
    */
    
    /// Disposable bag
    private var bag: Set<AnyCancellable>
//    private let configurator: MainConfigurator
    
    // MARK: - Life Cycle
    // TODO: Inject properties Configurator
    init() {
//        self.configurator = configurator
        
        // Initial values
        self.bag = []
        
        self.stateMachine = StateMachineSystem(
            stateMachine: StateMachine(
                initialState: .idle,
                transitions: MainModel.createTransitions()
            )
        )
        self.stateMachine.system
            .receive(on: RunLoop.main)
            .sink(receiveValue: { stateMachineOutput in
                Log.debug("New State: \(stateMachineOutput)")
            })
            // .assign(to: \.stateMachine, on: self)
            .store(in: &bag)
        
    }
    
    deinit {
        self.bag.removeAll()
    }
    
}

// MARK: - Action handling
extension MainViewModel {
    
    /// Method to publish incoming actions from the view
    func apply(event: Event) {
        self.stateMachine.apply(event: event)
    }
    
}
