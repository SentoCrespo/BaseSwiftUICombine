import Foundation

/// Defines a transition in the state machine
public struct Transition<State: StateType, Event: EventType, Effect: EffectType> {
    public var from: State
    public var event: Event
    public var to: State
    public var effect: Effect?
}
extension Transition: AutoEquatable, AutoHashable {}
