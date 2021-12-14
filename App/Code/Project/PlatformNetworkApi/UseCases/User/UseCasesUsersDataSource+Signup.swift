public extension UseCasesUsersDataSource {
    
    func signup(username: String, password: String) -> SignupResult {
        
        // TODO: Implement real request
        let user = User(id: "asdfghjk")
        let response = SuccessResponse(data: user, statusCode: 200)
        return Just(response)
            .setFailureType(to: ErrorResponse.self)
            .eraseToAnyPublisher()
    }
    
}
