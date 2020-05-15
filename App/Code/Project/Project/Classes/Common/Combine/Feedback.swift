import Foundation
import Combine

/// Processes that, given a state, trigger effects
/// depending on feedback events
struct Feedback<State, Effect> {
    
    // MARK: - Properties
    
    /// Transforms the given state with a given effect
    /// publishing a new state. f(currentState) = newState
    let run: (AnyPublisher<State, Never>) -> AnyPublisher<Effect, Never>
    
    // MARK: - Life Cycle
    init<FeedbackEvent: Publisher>(effects: @escaping (State) -> FeedbackEvent)
        where FeedbackEvent.Output == Effect, FeedbackEvent.Failure == Never {
            self.run = { state -> AnyPublisher<Effect, Never> in
                state
                    .map { effects($0) }
                    .switchToLatest()
                    .eraseToAnyPublisher()
            }
    }
    
}

