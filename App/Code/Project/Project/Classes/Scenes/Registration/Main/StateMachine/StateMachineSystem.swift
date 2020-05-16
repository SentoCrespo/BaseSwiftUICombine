import Foundation
import Combine

/// Wrapper around state machine to provide a combine publisher
class StateMachineSystem<State: StateType & Hashable & Equatable, Event: EventType & Hashable, Effect: EffectType & Hashable> {
    
    // MARK: - Properties
    typealias StateMachineOutput = (
        from: State,
        to: State,
        event: Event,
        effect: Effect?
    )
    var stateMachine: StateMachine<State, Event, Effect>
    var system = PassthroughSubject<StateMachineOutput, Never>()
    
    // MARK: - Life Cycle
    init(stateMachine: StateMachine<State, Event, Effect>) {
        self.stateMachine = stateMachine
    }
    
}

// MARK: - Public Methods
extension StateMachineSystem {
    
    func apply(event: Event) {
        let currentState = stateMachine.state
        let transitionResult = stateMachine.apply(event: event)
        
        switch transitionResult {
        case .failure(let error):
            Log.error("\(error) - Invalid transition, doing nothing")
        case .success(let result):
            let result: StateMachineOutput = (
                from: currentState,
                to: result.to,
                event: event,
                effect: result.effect
            )
            system.send(result)
        }
        
    }
    
}
