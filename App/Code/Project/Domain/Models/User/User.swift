// sourcery:AutoHashable,AutoEquatable,AutoInit
public struct User: Codable {
    
    // MARK: Properties
    public var id: String
    public var email: String?
    public var password: String?
    public var name: String?

// sourcery:inline:auto:User.AutoInit
    // MARK: - Life Cycle
    public init(
        id: String,
        email: String? = nil,
        password: String? = nil,
        name: String? = nil
        ) {
		self.id = id
		self.email = email
		self.password = password
		self.name = name
	}
// sourcery:end
}
