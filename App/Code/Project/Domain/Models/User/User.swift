import Foundation

// sourcery:AutoHashable,AutoEquatable
public struct User: Codable {
    
    // MARK: Properties
    public var id: String
    public var email: String?
    public var password: String?
    public var name: String?
    
    // MARK: Life Cycle
    public init(id: String) {
        self.id = id
    }

}
