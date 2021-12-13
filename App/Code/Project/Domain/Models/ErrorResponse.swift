import Foundation

// sourcery:AutoHashable,AutoEquatable
public struct ErrorResponse: Error, Codable {
    
    // MARK: - Properties
    public var statusCode: Int = 9999
    
    // MARK: - Life Cycle
    public init(statusCode: Int = 9999) {
        self.statusCode = statusCode
    }
    
}
