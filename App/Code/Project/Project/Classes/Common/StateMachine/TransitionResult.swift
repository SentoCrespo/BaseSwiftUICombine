import Foundation

public struct TransitionResult<State: StateType, Event: EventType, Effect: EffectType> {
    
    // MARK: - Variables
    public var from: State
    public var event: Event
    public var to: State
    public var effect: Effect?
    
}
