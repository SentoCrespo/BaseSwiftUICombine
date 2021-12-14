public struct SuccessResponse<T: Codable> {
    
    // MARK: - Properties
    public var data: T
    public var statusCode: Int?
    
    // MARK: - Life Cycle
    public init(data: T, statusCode: Int? = nil) {
        self.data = data
        self.statusCode = statusCode
    }
    
}
