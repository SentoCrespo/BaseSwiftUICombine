import Foundation

/// Defines transitions in the state machine
public typealias Transition<State: StateType, Event: EventType, Effect: EffectType> =
    (_ currentState: State, _ event: Event) -> (nextState: State, effect: Effect?)

public struct TransitionResult<State: StateType, Event: EventType, Effect: EffectType> {
    
    // MARK: - Variables
    var from: State
    var event: Event
    var to: State
    var effect: Effect?
    
}
