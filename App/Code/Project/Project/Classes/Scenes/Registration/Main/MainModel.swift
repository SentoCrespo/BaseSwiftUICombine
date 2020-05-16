import Foundation
import Combine

/// Scene Model Definition
struct MainModel {
    
    // MARK: - Variables
    
    /// General purpose variables
    struct Context {
        
    }
    
    /// State machine for the scene
    /// https://www.vadimbulavin.com/assets/images/posts/mvvm/movies-list-state-machine.svg
    enum State: StateType {
        case idle
        case loading
        case loaded([String])
        case error(Error)
    }
    
    /// Something happened
    enum Event: EventType {
        case onAppear
        case onReload
        case onSelect(String)
        case onLoadingSuccess([String])
        case onLoadingFailed(Error)
    }

    typealias ModuleTransition = Transition<MainModel.State, MainModel.Event, MainModel.Effect>
    
    /// Instructions to trigger logic
    enum Effect: EffectType {
        case loadItems
        case navigateToProfile
    }
    
    static func createTransitions() -> Set<ModuleTransition> {
        let transition1 = ModuleTransition(
            from: .idle,
            event: .onAppear,
            to: .loading,
            effect: .loadItems
        )
        let result: Set<ModuleTransition> = [
            transition1
        ]
        return result
    }
}

extension MainModel.State: AutoHashableEnumValues, AutoEquatableEnumValues {}
extension MainModel.Event: AutoHashableEnumValues, AutoEquatableEnumValues {}
extension MainModel.Effect: AutoHashableEnumValues, AutoEquatableEnumValues {}

//struct StateMachine {
//
////    typealias State = MainModel.State
////    typealias Event = MainModel.Event
////    typealias Effect = MainModel.Effect
////    typealias Transition = MainModel.Transition
//
//    var state: MainModel.State
//    var transitions: Set<MainModel.Transition>
//
//    enum MachineError: Error {
//        case invalidTransition
//    }
//
//    init(initialState: MainModel.State, transitions: Set<MainModel.Transition>) {
//        self.state = initialState
//        self.transitions = transitions
//    }
//
//    typealias HandleResult = (to: MainModel.State, effect: MainModel.Effect?)
//
//    mutating func apply(event: MainModel.Event) -> Result<HandleResult, MachineError> {
//        let fromState = self.state
//        let transitionResult = self.apply(from: fromState, event: event)
//        if case let .success(output) = transitionResult {
//            self.state = output.to
//        }
//        return transitionResult
//    }
//
//    private func apply(from: MainModel.State, event: MainModel.Event) -> Result<HandleResult, MachineError> {
//
//        let newValue: HandleResult? = transitions
//            .filter { $0.from == from }
//            .filter { $0.event == event }
//            .first // TODO: Check multiple transitions from same state with same event
//            .map { HandleResult(to: $0.to, effect: $0.effect) }
//
//        guard let result = newValue else {
//            return .failure(StateMachine.MachineError.invalidTransition)
//        }
//
//        return .success(result)
//    }
//
//}
//
//class StateMachineSystem {
//
////    typealias State = MainModel.State
////    typealias Event = MainModel.Event
////    typealias Effect = MainModel.Effect
////    typealias Transition = MainModel.Transition
//
//    var stateMachine: StateMachine
//    typealias StateMachineOutput = (
//        from: MainModel.State,
//        to: MainModel.State,
//        event: MainModel.Event,
//        effect: MainModel.Effect?
//    )
//    var system = PassthroughSubject<StateMachineOutput, Never>()
//
//    init(stateMachine: StateMachine) {
//        self.stateMachine = stateMachine
//    }
//
//    func apply(event: MainModel.Event) {
//        let currentState = stateMachine.state
//        let transitionResult = stateMachine.apply(event: event)
//
//        switch transitionResult {
//        case .failure(let error):
//            Log.error("\(error) - Invalid transition, doing nothing")
//        case .success(let result):
//            let result: StateMachineOutput = (
//                from: currentState,
//                to: result.to,
//                event: event,
//                effect: result.effect
//            )
//            system.send(result)
//        }
//
//    }
//
//}

/*
 la transicion es algo asi :   event -> (newState, effect)

 y los eventos y effects los separo cogiendo como event todo lo que se inicia por el usuario o sucede desde fuera, y como effect solo una descripcion de lo que se debe hacer a nivel logica (fetchX, saveToken, reloadX, openWebview, etc..)

 transicion tipica:
 viewDidLoad -> (loading, fetchProducts)
 */
