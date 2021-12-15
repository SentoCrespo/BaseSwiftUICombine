import Foundation

public struct AppReduxState: ReduxState {
    
    // MARK: - Properties
    var subState1: SubState1
    
}

public extension AppReduxState {
    
    static var initial: AppReduxState {
        return AppReduxState(
            subState1: SubState1(
                myGlobalVar: ""
            )
        )
    }
    
}
