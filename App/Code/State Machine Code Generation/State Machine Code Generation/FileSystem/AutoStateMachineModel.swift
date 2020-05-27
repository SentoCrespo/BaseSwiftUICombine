import Foundation

let autoStateMachineModelTemplate = """
// Generated using State Machine Code Generation {{VERSION}} — https://github.com/vCrespoP
// DO NOT EDIT

// swiftlint:disable all

extension {{MODEL_NAME}} {
    // MARK: - States
    /// State machine for the scene
    enum State: StateType {
        {{STATE_CASES}}
    }

    static let initialState: State = .{{STATE_INITIAL}}

    // MARK: - Events
    /// An action happened
    enum Event: EventType {
        {{EVENT_CASES}}
    }

    static let initialEvent: Event = .{{EVENT_INITIAL}}

    // MARK: - Effects
    /// Instructions to trigger logic
    enum Effect: EffectType {
        {{EFFECT_CASES}}
    }

    // MARK: - Transitions
    /// Finite State Machine definition
    static func createTransitions() -> ModuleTransition {
        let result: ModuleTransition = { state, event in
            switch (state, event) {
            {{TRANSITION_CASES}}
            default:
                assertionFailure("Invalid transition from '\\(state)' with '\\(event)'")
                return (nextState: state, effect: nil)
            }
        }
        return result
    }
    
}

extension {{MODEL_NAME}}.State: AutoHashableEnumValues, AutoEquatableEnumValues {}
extension {{MODEL_NAME}}.Event: AutoHashableEnumValues, AutoEquatableEnumValues {}
extension {{MODEL_NAME}}.Effect: AutoHashableEnumValues, AutoEquatableEnumValues {}
"""

