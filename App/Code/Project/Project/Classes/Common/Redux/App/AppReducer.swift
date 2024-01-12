import Foundation

func appReducer(state: inout AppReduxState, action: AppReduxAction) {
    
    switch(action) {
        case .subState1(let action1):
            subState1Reducer(state: &state, action: action1)
    }
    
}
