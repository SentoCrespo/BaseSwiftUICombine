import PRSharedUtils

public extension UseCasesUsersDataSource {
    
    func signup(username: String, password: String) -> PublisherDataSourceType<Domain.User> {
        switch self.responseType {
        case .success(let statusCode):
            let result = successResponse(statusCode: statusCode)
            return result
            
        case .error(let code):
            return opErrorResponse(code: code)
            
        case .timeout:
            return opTimeoutResponse()
        }
    }
    
}

extension UseCasesUsersDataSource {
    
    private func successResponse(statusCode: Int) -> PublisherDataSourceType<Domain.User> {
        let jsonName = "Signup"
        let json = JsonUtils.readDictionaryData(resourceName: jsonName, bundle: Bundle(for: type(of: self)))
        let data: Domain.User = Domain.User.parse(from: json?["user"])!
        let result = opSuccessResponse(statusCode: statusCode, data: data)
        return result
    }
    
}
