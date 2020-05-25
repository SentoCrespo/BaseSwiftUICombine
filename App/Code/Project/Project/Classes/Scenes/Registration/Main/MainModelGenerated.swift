extension MainModel {
/// State machine for the scene
enum State: StateType {
case idle
case loading
case loaded
case error
}
static let initialState: State = .idle
/// An action happened
enum Event: EventType {
case start
case onAppear
case onLoadingFailed(Error)
case onLoadingSuccess(String)
case onReload
case onSelect(String)
}
static let initialEvent: Event = .start
/// Instructions to trigger logic
enum Effect: EffectType {
case loadItems
case navigateToProfile
}
// MARK: - Transitions
// Finite State Machine definition
static func createTransitions() -> ModuleTransition {
let result: ModuleTransition = { state, event in
switch (state, event) {
case (_, .start):
return (nextState: .idle, effect: nil)
case (.idle, .onAppear):
return (nextState: .loading, effect: .loadItems)
case (.loading, .onLoadingFailed(let error)):
return (nextState: .error, effect: nil)
case (.loading, .onLoadingSuccess(let string)):
return (nextState: .loaded, effect: nil)
case (.loaded, .onReload):
return (nextState: .loading, effect: nil)
case (.loaded, .onSelect(let string)):
return (nextState: .loaded, effect: .navigateToProfile)
default:
assertionFailure("Invalid transition from '\(state)' with '\(event)'")
return (nextState: state, effect: nil)
}
}
return result
}
}
extension MainModel.State: AutoHashableEnumValues, AutoEquatableEnumValues {}
extension MainModel.Event: AutoHashableEnumValues, AutoEquatableEnumValues {}
extension MainModel.Effect: AutoHashableEnumValues, AutoEquatableEnumValues {}
