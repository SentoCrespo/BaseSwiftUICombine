import Foundation

/// Finite state machine implementation with:
/// - States
/// - Events
/// - Effects
/// - Transition (State1 --event--> (State2 + Effect?)
struct StateMachine<State: StateType & Hashable & Equatable, Event: EventType & Hashable, Effect: EffectType & Hashable> {
    
    // MARK: - Properties
    typealias StateTransition = Transition<State, Event, Effect>
    var state: State
    var transitions: Set<StateTransition>
    
    // MARK: - Life Cycle
    init(initialState: State, transitions: Set<StateTransition>) {
        self.state = initialState
        self.transitions = transitions
    }
    
}
  
// MARK: - Public Methods
extension StateMachine {
    
    typealias HandleResult = (to: State, effect: Effect?)
    mutating func apply(event: Event) -> Result<HandleResult, StateMachineError> {
        // Get current State
        let fromState = self.state
        // Apply transition
        let transitionResult = self.apply(from: fromState, event: event)
        // In case it succeeded, change current state to the new one
        if case let .success(output) = transitionResult {
            self.state = output.to
        }
        // Return result for external use
        return transitionResult
    }
    
}

private extension StateMachine {
    
    func apply(from: State, event: Event) -> Result<HandleResult, StateMachineError> {
        
        let newValue: HandleResult? = transitions
            .filter { $0.from == from }
            .filter { $0.event == event }
            .first // TODO: Check multiple transitions from same state with same event
            // ambiguousTransition
            .map { HandleResult(to: $0.to, effect: $0.effect) }
        
        guard let result = newValue else {
            return .failure(StateMachineError.invalidTransition)
        }
        
        return .success(result)
    }
    
}

