import Foundation
import Combine

/// Wrapper around state machine to provide a combine publisher
public class StateMachineSystem<State: StateType, Event: EventType, Effect: EffectType> {
    
    // MARK: - Properties
    public var stateMachine: StateMachine<State, Event, Effect>
    public var system = PassthroughSubject<TransitionResult<State, Event, Effect>, Never>()
    
    // MARK: - Life Cycle
    init(stateMachine: StateMachine<State, Event, Effect>) {
        self.stateMachine = stateMachine
    }
    
}

// MARK: - Public Methods
public extension StateMachineSystem {
    
    func apply(event: Event) {
        let transitionResult = stateMachine.apply(event: event)
        
        switch transitionResult {
        case .failure(let error):
            Log.error("\n\(error) - (\(self.stateMachine.state) --> \(event)")
        case .success(let result):
            var debugString = "\n\(result.from) --\(result.event)--> \(result.to)"
            if let effect = result.effect {
                debugString.append(" + \(effect)")
            }
            Log.debug(debugString)
            system.send(result)
        }
        
    }
    
}
