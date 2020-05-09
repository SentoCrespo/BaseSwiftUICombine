import Foundation
import Combine

public protocol UseCasesUsersDataSource {
    
    typealias SignupResult = AnyPublisher<SuccessResponse<User>, ErrorResponse>
    func signup(username: String, password: String) -> SignupResult
    
//    func login(username: String, password: String) -> Future<SuccessResponse<User>, Error>
//
//    func loginWithFacebook(token: String) -> Future<SuccessResponse<User>, Error>
//
//    func loginWithGoogle(token: String) -> Future<SuccessResponse<User>, Error>
//
//    func loginWithApple(appleId: String) -> Future<SuccessResponse<User>, Error>
//
//    func forgotPassword(username: String) -> Future<SuccessResponse<Empty>, Error>
    
}
