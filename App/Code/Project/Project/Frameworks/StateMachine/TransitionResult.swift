import Foundation

public struct TransitionResult<State: StateType, Event: EventType, Effect: EffectType> {
    
    // MARK: - Variables
    public var from: State
    public var event: Event
    public var to: State
    public var effect: Effect?
    
}

extension TransitionResult: CustomStringConvertible {
    
    public var description: String {
        var result = "\(self.from) ~~\(self.event)~~> \(self.to)"
        if let effect = self.effect {
            result.append(" + \(effect)")
        }
        return result
    }
    
}
