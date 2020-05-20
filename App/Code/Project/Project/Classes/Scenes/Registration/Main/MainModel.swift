import Foundation
import Combine

/// Domain definition for the scene
struct MainModel {
    
    // MARK: - Variables
    
    /// General purpose variables
    struct Context {
        
    }
    
    /// State machine for the scene
    /// https://www.vadimbulavin.com/assets/images/posts/mvvm/movies-list-state-machine.svg
    enum State: StateType {
        case idle
        case loading
        case loaded([String])
        case error(Error)
    }
    
    /// An action happened
    enum Event: EventType {
        case none // Used for initial state
        case onAppear
        case onReload
        case onSelect(String)
        case onLoadingSuccess([String])
        case onLoadingFailed(Error)
    }

    // Transition from one state to another
    typealias ModuleTransition = Transition<MainModel.State, MainModel.Event, MainModel.Effect>
    
    /// Instructions to trigger logic
    enum Effect: EffectType {
        case loadItems
        case navigateToProfile
    }
    
}

extension MainModel.State: AutoHashableEnumValues, AutoEquatableEnumValues {}
extension MainModel.Event: AutoHashableEnumValues, AutoEquatableEnumValues {}
extension MainModel.Effect: AutoHashableEnumValues, AutoEquatableEnumValues {}

// MARK: - Transitions
extension MainModel {
    
    // Finite State Machine definition
    static func createTransitions() -> ModuleTransition {
        let result: ModuleTransition = { state, event in
            switch (state, event) {
            case (.idle, .onAppear):
                return (nextState: .loading, effect: .loadItems)
            case (.loading, .onLoadingFailed(let error)):
                return (nextState: .error(error), effect: nil)
            case (.loading, .onLoadingSuccess(let data)):
                return (nextState: .loaded(data), effect: nil)
            case (.loaded, .onReload):
                return (nextState: .loading, effect: .loadItems)
            case (_, .onSelect):
                return (nextState: state, effect: .navigateToProfile)
            case (_, .none):
                return (nextState: state, effect: nil)
            default:
                assertionFailure("Invalid transition from '\(state)' with '\(event)'")
                return (nextState: state, effect: nil)
            }
            
        }
            
        return result
    }
    
}
