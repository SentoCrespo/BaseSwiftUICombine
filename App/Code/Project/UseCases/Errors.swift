import Foundation

// sourcery:AutoEquatable,AutoHashable
public enum PRError: Error {
    case invalidUsername
    case parsing(message: String)
}
