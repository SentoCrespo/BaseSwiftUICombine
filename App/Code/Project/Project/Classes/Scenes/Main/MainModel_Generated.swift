// Generated using State Machine Code Generation 0.1 — https://github.com/SentoCrespo
// DO NOT EDIT

// swiftlint:disable all

extension MainModel {
    // MARK: - States
    // sourcery: AutoEquatableEnumValues, AutoHashableEnumValues
    /// State machine for the scene
    enum State: StateType {
        case idle
		case loading
		case loaded
		case error
    }

    static let initialState: State = .idle

    // MARK: - Events
    // sourcery: AutoEquatableEnumValues, AutoHashableEnumValues
    /// An action happened
    enum Event: EventType {
        case start
		case onAppear
		case onLoadingFailed(Error)
		case onLoadingSuccess(String)
		case onReload
		case onSelect(String)
		case onSwipe(String)
    }

    static let initialEvent: Event = .start

    // MARK: - Effects
    // sourcery: AutoEquatable, AutoHashable
    /// Instructions to trigger logic
    enum Effect: EffectType {
        case loadItems
		case navigateToProfile
		case removeItem
    }

    // MARK: - Transitions
    /// Finite State Machine definition
    static func createTransitions() -> ModuleTransition {
        let result: ModuleTransition = { state, event in
            switch (state, event) {
            case (_, .start):
				return (nextState: .idle, effect: nil)
			case (.idle, .onAppear):
				return (nextState: .loading, effect: .loadItems)
			case (.loading, .onLoadingFailed):
				return (nextState: .error, effect: nil)
			case (.loading, .onLoadingSuccess):
				return (nextState: .loaded, effect: nil)
			case (.loaded, .onReload):
				return (nextState: .loading, effect: nil)
			case (.loaded, .onSelect):
				return (nextState: .loaded, effect: .navigateToProfile)
			case (.loaded, .onSwipe):
				return (nextState: .loaded, effect: .removeItem)
            default:
                assertionFailure("Invalid transition from '\(state)' with '\(event)'")
                return (nextState: state, effect: nil)
            }
        }
        return result
    }
    
}
