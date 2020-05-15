import Foundation
import Combine

class MainViewModel: ObservableObject {

    // MARK: - Typealias
    typealias State = MainModel.State
    typealias Event = MainModel.State.Event
    typealias Effect = MainModel.State.Effect
    
    // MARK: - Properties
    /// State that will be observed by the view
    @Published private(set) var state: State
    
    /// Actions comming from the view
    private let input: PassthroughSubject<Event, Never>
    private let output: PassthroughSubject<Effect, Never>
    
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
        self.state = .idle
        self.bag = []
        self.input = PassthroughSubject<Event, Never>()
        self.output = PassthroughSubject<Effect, Never>()
        
        // Handle actions & effects
        self.handleActions(input: input)
        self.handleEffects()
    }
    
    deinit {
        self.bag.removeAll()
    }
    
}

// MARK: - Action handling
extension MainViewModel {
    
    /// Method to publish incoming actions from the view
    func send(event: Event) {
        self.input.send(event)
    }
    
}
   
// MARK: - Private Action handling
private extension MainViewModel {
    
    /// Porcess incoming view actions
    /// trigger state changes or navigation
    func handleActions(input: PassthroughSubject<Event, Never>) {
        
        // Initial state value
        // let state = CurrentValueSubject<State, Never>(.idle)
            
        input
            .receive(on: RunLoop.main)
            .sink(receiveValue: { event in
                switch event {
                    case .onAppear:
                        self.state = .loading
                    case .onReload:
                        self.state = .loading
                    case .onSelect(let item):
                        Log.debug("Process selected item: \(item)")
                    default:
                        break
                }
            })
            .store(in: &bag)
    }
    
}
    
// MARK: - State handling
private extension MainViewModel {

    /// Define state-to-state transitions (state machine)
    static func reduce(_ state: State, _ effect: Effect) -> State {
        switch state {
            case .idle:
                return state
            case .loading:
                switch effect {
                default:
                    return state
                }
            case .loaded:
                return state
            case .error:
                return state
        }
    }
    
}

// MARK: - Effects Handling
extension MainViewModel {
    
    /// Process state-to-state transitions
    func handleEffects() {
    
        // Initial state value
        let state = self.state
    
        Publishers
            .system(
                initial: state,
                reduce: Self.reduce,
                scheduler: RunLoop.main,
                feedbacks: [
                    
                ])
            .assign(to: \.state, on: self)
            .store(in: &bag)
    }

}

// MARK: - Concrete Effect handling
private extension MainViewModel {

    static func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            // Check for the state we should be at
            guard case .loading = state else {
                return Empty().eraseToAnyPublisher()
            }
            
            // Do operations and return effects
            let result = Event.onLoadingSuccess([])
            return Just(result)
                .eraseToAnyPublisher()
            //              .catch { Just(Event.onLoadingFailed($0)) }
        }
        
    }
    
}
