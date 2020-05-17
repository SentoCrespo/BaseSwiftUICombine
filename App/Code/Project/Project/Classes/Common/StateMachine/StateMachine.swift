import Foundation

/// Finite state machine implementation with:
/// - States
/// - Events
/// - Effects
/// - Transition (currentState --event--> (nextState + Effect?)
public struct StateMachine<State: StateType, Event: EventType, Effect: EffectType> {
    
    // MARK: - Properties
    public typealias StateTransition = Transition<State, Event, Effect>
    public typealias StateTransitionResult = TransitionResult<State, Event, Effect>
    public var initialState: State
    public var state: State
    public var transitions: StateTransition
    
    // MARK: - Life Cycle
    init(initialState: State, transitions: @escaping StateTransition) {
        self.initialState = initialState
        self.state = initialState
        self.transitions = transitions
    }
    
}
  
// MARK: - Public Methods
public extension StateMachine {
    
    mutating func apply(event: Event) -> Result<StateTransitionResult, StateMachineError> {
        // Get current State
        let fromState = self.state
        // Apply transition
        let transitionResult = self.apply(from: fromState, event: event)
        // In case it succeeded, change current state to the new one
        if case let .success(result) = transitionResult {
            self.state = result.to
        }
        // Return result for external use
        return transitionResult
    }
    
    mutating func resetToInitialState() {
        self.state = self.initialState
    }
    
}

private extension StateMachine {
    
    func apply(from: State, event: Event) -> Result<StateTransitionResult, StateMachineError> {
        
        let output = self.transitions(from, event)
        let result = StateTransitionResult(
            from: from,
            event: event,
            to: output.nextState,
            effect: output.effect
        )
        
        return .success(result)
    }
    
}

