import Foundation

/// Finite state machine implementation with:
/// - States
/// - Events
/// - Effects
/// - Transition (State1 --event--> (State2 + Effect?)
public struct StateMachine<State: StateType, Event: EventType, Effect: EffectType> {
    
    // MARK: - Properties
    public typealias StateTransition = Transition<State, Event, Effect>
    public var initialState: State
    public var state: State
    public var transitions: Set<StateTransition>
    
    // MARK: - Life Cycle
    init(initialState: State, transitions: Set<StateTransition>) {
        self.initialState = initialState
        self.state = initialState
        self.transitions = transitions
    }
    
}
  
// MARK: - Public Methods
public extension StateMachine {
    
    mutating func apply(event: Event) -> Result<StateTransition, StateMachineError> {
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
    
    mutating func resetToInitialState() {
        self.state = self.initialState
    }
    
}

private extension StateMachine {
    
    func apply(from: State, event: Event) -> Result<StateTransition, StateMachineError> {
        
        let transitionsFiltered: [StateTransition] = transitions
            .filter { $0.from == from }
            .filter { $0.event == event }
        
        // If no transitions have been found, it's invalid
        guard transitionsFiltered.isEmpty == false else {
            return .failure(StateMachineError.invalidTransition)
        }
        
        // If there's more than one transition, it's not finite
        guard transitionsFiltered.count == 1 else {
            return .failure(StateMachineError.ambiguousTransition)
        }
        
        // Valid transition found
        return .success(transitionsFiltered.first!)
    }
    
}

