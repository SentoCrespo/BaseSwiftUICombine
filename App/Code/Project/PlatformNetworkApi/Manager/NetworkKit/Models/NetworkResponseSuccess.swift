import VCNetworkKit

public struct NetworkResponseSuccess<T: Decodable> {
    
    // MARK: - Properties
    public var data: T
    public var httpResponse: HttpResponse
    
    // MARK: - Life Cycle
    public init(data: T, httpResponse: HttpResponse) {
        self.data = data
        self.httpResponse = httpResponse
    }
    
}
