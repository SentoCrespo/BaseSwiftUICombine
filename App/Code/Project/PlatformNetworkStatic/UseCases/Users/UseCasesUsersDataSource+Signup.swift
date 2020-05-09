import Domain
import Foundation
import Combine
import SharedUtils

public extension UseCasesUsersDataSource {
    
    func signup(username: String, password: String) -> PublisherDataSourceType<User> {
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
    
    private func successResponse(statusCode: Int) -> PublisherDataSourceType<User> {
        let jsonName = "Signup"
        let json = JsonUtils.readDictionaryData(resourceName: jsonName, bundle: Bundle(for: type(of: self)))
        let data: User = User.parse(from: json?["user"])!
        let result = opSuccessResponse(statusCode: statusCode, data: data)
        return result
    }
    
}
