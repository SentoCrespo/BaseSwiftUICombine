public protocol UserDataSource {
    
    typealias SignupResult = AnyPublisher<SuccessResponse<Domain.User>, ErrorResponse>
    func signup(username: String, password: String) -> SignupResult
    
}
