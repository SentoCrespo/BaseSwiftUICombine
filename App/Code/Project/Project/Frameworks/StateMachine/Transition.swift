import Foundation

/// Defines transitions in the state machine
public typealias Transition<State: StateType, Event: EventType, Effect: EffectType> =
    (_ currentState: State, _ event: Event) -> (nextState: State, effect: Effect?)
