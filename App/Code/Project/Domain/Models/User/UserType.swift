import Foundation

// sourcery:AutoHashable,AutoEquatable
public enum UserType: String, Codable {
    case client = "Client"
    case admin = "Admin"
}
