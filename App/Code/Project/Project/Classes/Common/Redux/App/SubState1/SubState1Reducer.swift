import Foundation

func subState1Reducer(state: inout AppReduxState, action: SubState1Action) {
    switch(action) {
        case .myAction:
            state.subState1.myGlobalVar = "Changed"
    }
}
