import Foundation

// MARK: - Errors
public enum StateMachineError: Error {
    case invalidTransition
    case ambiguousTransition
}
