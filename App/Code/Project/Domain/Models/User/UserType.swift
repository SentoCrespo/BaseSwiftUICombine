import Foundation

public enum UserType: String, Codable {
    case client = "Client"
    case admin = "Admin"
}

extension UserType: AutoEquatable, AutoHashable {}
