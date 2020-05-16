import Foundation

// MARK: - Transition
struct Transition<State: StateType & Hashable & Equatable, Event: EventType & Hashable & Equatable, Effect: EffectType & Hashable & Equatable> {
    var from: State
    var event: Event
    var to: State
    var effect: Effect?
}
extension Transition: AutoEquatable, AutoHashable {}
