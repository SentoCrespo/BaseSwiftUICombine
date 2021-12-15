import Foundation
import Combine

/// Holds the State of the app (read-only access)
public final class ReduxStore<ReduxState, ReduxAction>: ObservableObject {
    
    // MARK: - Typealias
    typealias Reducer = ReduxReducer<ReduxState, ReduxAction>
    typealias Middleware = ReduxMiddleware<ReduxState, ReduxAction>
    
    // MARK: - Properties
    @Published private(set) public var state: ReduxState // Read-only access to app state
    private let reducer: Reducer
    
    // Middleware
    var tasks: [AnyCancellable] = []
    let serialQueue = DispatchQueue(label: "redux.serial.queue")
    let middlewares: [Middleware]
    private var middlewareCancellables: Set<AnyCancellable> = []
    
    // MARK: - Life Cycle
    init(initialState: ReduxState,
         reducer: @escaping Reducer,
         middlewares: [Middleware]) {
        self.state = initialState
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
}
    
public extension ReduxStore {
    
    /// Dispatches actions to the reducer & middlewares
    func dispatch(_ action: ReduxAction) {
        
        // Ensure actions are dispatched in order
        self.serialQueue.sync {
            reducer(&state, action)
        }
        
        self.middlewares.forEach { mw in
            let middleware = mw(state, action)
            middleware
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &middlewareCancellables)
        }
    }
    
}
