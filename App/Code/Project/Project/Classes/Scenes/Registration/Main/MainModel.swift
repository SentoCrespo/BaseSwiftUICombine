import Foundation
import Combine

/// Domain definition for the scene
struct MainModel: SceneModel {
    
    // MARK: - Variables
    
    /// General purpose variables
    struct Context {
        
    }
    
    /// State machine for the scene
    enum State: StateType {
        case idle
        case loading
        case loaded(String)
        case error(Error)
    }
    
    static let initialState: State = .idle
    
    /// An action happened
    enum Event: EventType {
        case start // Used for initial state
        case onAppear
        case onReload
        case onSelect(String)
        case onLoadingSuccess(String)
        case onLoadingFailed(Error)
    }
    static let initialEvent: Event = .start
    
    // Transition from one state to another
    
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
            // Initial state
            case (_, .start):
                return (nextState: state, effect: nil)
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
            default:
                assertionFailure("Invalid transition from '\(state)' with '\(event)'")
                return (nextState: state, effect: nil)
            }
            
        }
            
        return result
    }
    
}
