import Foundation

protocol SceneModel {
    // MARK: - Associated Types & Typealias
    associatedtype State: StateType
    associatedtype Event: EventType
    associatedtype Effect: EffectType
    typealias ModuleTransition = Transition<State, Event, Effect>
    
    // MARK: - Properties
    static var initialState: State { get }
    static var initialEvent: Event { get }
    
    // MARK: - Methods
    static func createTransitions() -> ModuleTransition
}
