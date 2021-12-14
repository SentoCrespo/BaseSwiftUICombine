import VCNetworkKit

/// Example usage:
/// ```
/// let cancellable = service
///     .request(requestTest)
///     .handleEvents(
///         receiveSubscription: { subscription in
///             Log.debug("Subscription: \(subscription)")
///     },
///         receiveOutput: { (response: NetworkResponseSuccess<Todo>) in
///             Log.debug("Response: \(response)")
///     },
///         receiveCompletion: { completion in
///             Log.debug("Completion: \(completion)")
///     },
///         receiveCancel: {
///             Log.debug("Cancel")
///     },
///         receiveRequest: { request in
///             Log.debug("Receive request: \(request)")
///     })
///     .sink(
///         receiveCompletion: { _ in },
///         receiveValue: { (value: NetworkResponseSuccess<Todo>) in
///             Log.debug("Sink Value: \(value)")
///     })
///     // .store(in: &disposeBag)
///
/// cancellable.cancel()
/// ```
public class NetworkServiceCombine {
    
    // MARK: - Properties
    public let baseUrl: URL
    public let session: URLSession
    public let isDebugMode: Bool
    
    // MARK: - Life Cycle
    public required init(baseUrl: URL, session: URLSession, isDebugMode: Bool) {
        self.baseUrl = baseUrl
        self.session = session
        self.isDebugMode = isDebugMode
    }
    
    public convenience init(baseUrl: URL) {
        self.init(
            baseUrl: baseUrl,
            session: URLSession(configuration: .default),
            isDebugMode: false)
    }
    
}

public extension NetworkServiceCombine {
    
    func request<T: Decodable>(_ request: Request) -> AnyPublisher<NetworkResponseSuccess<T>, Error> {
        
        switch request.urlRequest(baseUrl: self.baseUrl) {
        case .failure(let error):
            let result = Fail<NetworkResponseSuccess<T>, Error>(error: error)
                .eraseToAnyPublisher()
            return result
            
        case .success(let urlRequest):
            return self.session
                .dataTaskPublisher(for: urlRequest)
                // Parse response
                .tryMap { result -> NetworkResponseSuccess<T> in
                    let value = try JSONDecoder().decode(T.self, from: result.data)
                    let httpUrlResponse = result.response as? HTTPURLResponse
                    let httpResponse = HttpResponse(
                        httpUrlResponse: httpUrlResponse!,
                        url: self.baseUrl,
                        data: result.data
                    )
                    return NetworkResponseSuccess(data: value, httpResponse: httpResponse)
                }
                // Validate status code
                .tryMap { result -> NetworkResponseSuccess<T> in
                    let statusCode = result.httpResponse.responseCode
                    guard request.successCodes.contains(statusCode) else {
                        throw UrlSessionError.statusCode(statusCode)
                    }
                    return result
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        }
        
    }
    
}
