import Foundation
import Combine

protocol SceneViewModel {
    
    // MARK: - Associated Types & Typealias
    associatedtype Model: SceneModel
    typealias TransitionOutput = TransitionResult<Model.State, Model.Event, Model.Effect>
    
    // MARK: - Variables
    /// State transitions that will be observed by the view
    var output: TransitionOutput { get set }
    
    // MARK: - Properties
    var stateMachineSystem: StateMachineSystem<Model.State, Model.Event, Model.Effect> { get }
    var disposeBag: Set<AnyCancellable> { get set }
    var configurator: SceneConfigurator { get }
    
    // MARK: - Life Cycle
    init(configurator: SceneConfigurator)
    
    // MARK: - Public Methods
    /// Method to publish incoming actions from the view
    func apply(event: Model.Event)
    func handle(effect: Model.Effect)
    
}

extension SceneViewModel {
    
    func apply(event: Model.Event) {
        self.stateMachineSystem.apply(event: event)
    }

}
