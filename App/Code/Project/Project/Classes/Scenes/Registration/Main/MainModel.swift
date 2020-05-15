import Foundation

/// Scene Model Definition
struct MainModel {
    
    // MARK: - Variables
    
    /// General purpose variables
    struct Context {
        
    }
    
    /// State machine for the scene
    /// https://www.vadimbulavin.com/assets/images/posts/mvvm/movies-list-state-machine.svg
    enum State {
        case idle
        case loading
        case loaded([String])
        case error(Error)
        
        /// Something happened
        enum Event {
            case onAppear
            case onReload
            case onSelect(String)
            case onLoadingSuccess([String])
            case onLoadingFailed(Error)
        }

        /// Instructions to trigger logic
        enum Effect {
            case loadItems
            case navigateToProfile
        }
        
    }
    
}

extension MainModel.State: AutoHashableEnumValues, AutoEquatableEnumValues {}
extension MainModel.State.Event: AutoHashableEnumValues, AutoEquatableEnumValues {}
extension MainModel.State.Effect: AutoHashableEnumValues, AutoEquatableEnumValues {}

/*
 la transicion es algo asi :   event -> (newState, effect)

 y los eventos y effects los separo cogiendo como event todo lo que se inicia por el usuario o sucede desde fuera, y como effect solo una descripcion de lo que se debe hacer a nivel logica (fetchX, saveToken, reloadX, openWebview, etc..)

 transicion tipica:
 viewDidLoad -> (loading, fetchProducts)
 */
