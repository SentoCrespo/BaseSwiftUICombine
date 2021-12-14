import Foundation
import Combine

public protocol UseCasesUsersDataSource {
    
    typealias SignupResult = AnyPublisher<SuccessResponse<User>, ErrorResponse>
    func signup(username: String, password: String) -> SignupResult
    
}
