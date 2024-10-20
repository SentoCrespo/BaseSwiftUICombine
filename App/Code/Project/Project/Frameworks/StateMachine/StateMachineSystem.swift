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
        let transitionResult = self.stateMachine.apply(event: event)
        
        switch transitionResult {
            case .failure(let error):
                print("Transition error: \(error)")
                
            case .success(let result):
                system.send(result)
        }
        
    }
    
}
