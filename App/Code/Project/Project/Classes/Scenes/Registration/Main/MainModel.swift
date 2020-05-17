import Foundation
import Combine

/// Scene Model Definition
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
    
    /// Something happened
    enum Event: EventType {
        case onAppear
        case onReload
        case onSelect(String)
        case onLoadingSuccess([String])
        case onLoadingFailed(Error)
    }

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
    
    static func createTransitions() -> Set<ModuleTransition> {
        let result: Set<ModuleTransition> = [
            ModuleTransition(
                from: .idle, event: .onAppear, to: .loading, effect: .loadItems
            ),
            ModuleTransition(
                from: .loading, event: .onLoadingSuccess(["Result"]), to: .loaded(["Result"]), effect: nil
            )
//            ModuleTransition(
//                from: .loading, event: .onLoadingFailed, to: .error, effect: nil
//            )
        ]
        return result
    }
    
}
