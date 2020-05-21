import Foundation
import Combine

protocol SceneViewModel {
    
    // MARK: - Associated Types & Typealias
    associatedtype State: StateType
    associatedtype Event: EventType
    associatedtype Effect: EffectType
    associatedtype Model: SceneModel
    typealias TransitionOutput = TransitionResult<Model.State, Model.Event, Model.Effect>
    
    // MARK: - Variables
    /// State transitions that will be observed by the view
    var output: TransitionOutput { get set }
    
    // MARK: - Properties
    var stateMachineSystem: StateMachineSystem<State, Event, Effect> { get }
    var disposeBag: Set<AnyCancellable> { get set }
    var configurator: SceneConfigurator { get }
    
    // MARK: - Life Cycle
    init(configurator: SceneConfigurator)
    
    // MARK: - Public Methods
    /// Method to publish incoming actions from the view
    func apply(event: Event)
    func handle(effect: Effect)
    
}

extension SceneViewModel {
    
    func apply(event: Event) {
        self.stateMachineSystem.apply(event: event)
    }

}
