public enum User {
    
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

public extension User {
    
    typealias SignupResult = AnyPublisher<SuccessResponse<Domain.User>, ErrorUseCasesUser>
    static func signup(username: String,
                       password: String,
                       repeatPassword: String,
                       dataSource: UserDataSource) -> SignupResult {
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
