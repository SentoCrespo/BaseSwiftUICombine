import Foundation
import Combine

func logMiddleware() -> ReduxMiddleware<AppReduxState, AppReduxAction> {
    
    return { state, action in
        Swift.print("--- Redux action: \(action)")
        return Empty().eraseToAnyPublisher()
    }
    
}
