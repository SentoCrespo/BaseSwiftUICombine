import Foundation

// MARK: - Errors
enum StateMachineError: Error {
    case invalidTransition
    case ambiguousTransition
}
