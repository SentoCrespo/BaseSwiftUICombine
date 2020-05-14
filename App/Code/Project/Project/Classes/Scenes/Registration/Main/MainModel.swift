import Foundation

/// Scene Model Definition
struct MainModel {
    
    /// State machine for the scene
    /// https://www.vadimbulavin.com/assets/images/posts/mvvm/movies-list-state-machine.svg
    enum State {
        case idle
        case loading
        case loaded([String])
        case error(Error)
    }
    
    /// Anything triggered from the view
    enum Effect {
        case onSelect(String)
    }

    /// Anything a user does on a screen
    enum Event {
        case onAppear
        case onLoadingSuccess([String])
        case onLoadingFailed(Error)
    }
    
}

extension MainModel.State: AutoHashableEnumValues, AutoEquatableEnumValues {}
extension MainModel.Effect: AutoHashableEnumValues, AutoEquatableEnumValues {}
extension MainModel.Event: AutoHashableEnumValues, AutoEquatableEnumValues {}
