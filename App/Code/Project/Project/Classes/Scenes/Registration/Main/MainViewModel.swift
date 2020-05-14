import Foundation
import Combine

class MainViewModel: ObservableObject {

    // MARK: - Properties
    @Published private(set) var state: MainModel.State = .idle
    private var bag = Set<AnyCancellable>()
    private let input = PassthroughSubject<MainModel.Event, Never>()
    
    // MARK: - Life Cycle
    /// Connect Dependencies and start state machine
    init() {
//        Publishers.system(
//            initial: state,
//            reduce: Self.reduce,
//            scheduler: RunLoop.main,
//            feedbacks: [
//                // 2.
//                Self.whenLoading(),
//                Self.userInput(input: input.eraseToAnyPublisher())
//            ]
//        )
//        .assign(to: \.state, on: self)
//        .store(in: &bag)
    }
    
    deinit {
        self.bag.removeAll()
    }
    
    // TODO: WHY THIS?
    func send(event: MainModel.Event) {
        self.input.send(event)
    }
    
}

// MARK: - Define state-to-state transitions
extension MainViewModel {
    
    typealias State = MainModel.State
    typealias Event = MainModel.Event
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            switch event {
            case .onAppear:
                return .loading
            default:
                return state
            }
        case .loading:
            switch event {
            case .onLoadingFailed(let error):
                return .error(error)
            case .onLoadingSuccess(let movies):
                return .loaded(movies)
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

// MARK: - Handle Events
extension MainViewModel {
    
    typealias Effect = MainModel.Effect
    static func userInput(input: AnyPublisher<State, Never>) -> Feedback<State, Event> {
        Feedback { _ in input
            
        }
    }
    
}


// MARK: - Handle Effects
extension MainViewModel {
    
//    func observeViewEffect() {
//        input.
//            .asObservable()
//            .subscribe(onNext: { [unowned self] viewEffect in
//                switch viewEffect {
//                case .confirmingDropoff:
//                    self.state.set {
//                        $0.dropoffButtonState = .loading
//                    }
//                    
//                case let .confirmedDropoff(ride):
//                    self.viewState.set {
//                        $0.dropoffButtonState = .disabled
//                    }
//                    
//                    self.coordinator?.dropOffPassenger(ride: ride)
//                    
//                case .confirmDropoffFailed:
//                    self.viewState.set {
//                        $0.dropoffButtonState = .default
//                    }
//                }
//            })
//            .disposed(by: disposeBag)
//    }
    
}

