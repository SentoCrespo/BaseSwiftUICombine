// sourcery:AutoInit
public struct SuccessResponse<T: Codable> {
    
    // MARK: - Properties
    public var data: T
    public var statusCode: Int?
    

// sourcery:inline:auto:SuccessResponse.AutoInit

    // MARK: - Life Cycle

    public init(

        data: T,

        statusCode: Int? = nil

        ) {

		self.data = data

		self.statusCode = statusCode

	}
// sourcery:end
}
