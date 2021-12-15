import Foundation

typealias AppReduxStore = ReduxStore<AppReduxState, AppReduxAction>

let store: AppReduxStore = AppReduxStore(
    initialState: AppReduxState.initial,
    reducer: appReducer,
    middlewares: [
        logMiddleware()
    ]
)
