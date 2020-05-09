import Foundation

public enum PRError: Error {
    case invalidUsername
    case parsing(message: String)
}

extension PRError: AutoEquatable, AutoHashable {}
