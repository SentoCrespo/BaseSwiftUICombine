public typealias PublisherDataSourceType<T: Codable> = AnyPublisher<SuccessResponse<T>, ErrorResponse>

public class BaseUseCaseDataSource {
    
    // MARK: - Properties
    let responseType: ResponseType
    let delay: DispatchTimeInterval
    
    // MARK: - Life Cycle
    public init(responseType: ResponseType = .success(code: 200),
                delay: DispatchTimeInterval = .seconds(0)) {
        self.responseType = responseType
        self.delay = delay
    }
    
}

extension BaseUseCaseDataSource {
    
    func opSuccessResponse<T: Codable>(statusCode: Int, data: T) -> PublisherDataSourceType<T> {
        let response = SuccessResponse<T>(data: data, statusCode: statusCode)
        let result: PublisherDataSourceType<T> = Just(response)
            .setFailureType(to: ErrorResponse.self)
            .delay(for: .init(self.delay), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
            
        return result

    }
    
    func opErrorResponse<T: Codable>(code: Int) -> PublisherDataSourceType<T> {
        let error = ErrorResponse(statusCode: code)
        let result = Fail<SuccessResponse<T>, ErrorResponse>(error: error)
            .delay(for: .init(self.delay), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
        return result
    }

    func opTimeoutResponse<T: Codable>() -> PublisherDataSourceType<T> {
        let error = ErrorResponse(statusCode: 9999)
        let result = Fail<SuccessResponse<T>, ErrorResponse>(error: error)
            .delay(for: .init(self.delay), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
        return result
    }
    
}
