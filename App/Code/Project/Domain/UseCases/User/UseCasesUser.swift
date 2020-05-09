import Foundation
import Combine

public enum UseCasesUser {
    
    // MARK: - Properties
    public enum ErrorUseCasesUser: Error {
        case invalidUsername
        case parsing(message: String)
        case other(Error)
        
        static func map(_ error: Error) -> ErrorUseCasesUser {
          return (error as? ErrorUseCasesUser) ?? .other(error)
        }
    }
    
}

public extension UseCasesUser {
    
    typealias SignupResult = AnyPublisher<SuccessResponse<User>, ErrorUseCasesUser>
    static func signup(username: String,
                       password: String,
                       repeatPassword: String,
                       dataSource: UseCasesUsersDataSource) -> SignupResult {
        // TODO: Preconditions + Unit testing
        return dataSource
            .signup(username: username, password: password)
            .mapError { errorResponse in
                switch errorResponse.statusCode {
                default:
                    return ErrorUseCasesUser.map(errorResponse)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
