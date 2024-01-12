// sourcery:AutoHashable,AutoEquatable,AutoInit
public struct ErrorResponse: Error, Codable {
    
    // MARK: - Properties
    public var statusCode: Int = 9999

// sourcery:inline:auto:ErrorResponse.AutoInit

    // MARK: - Life Cycle

    public init(

        statusCode: Int

        ) {

		self.statusCode = statusCode

	}
// sourcery:end
}
