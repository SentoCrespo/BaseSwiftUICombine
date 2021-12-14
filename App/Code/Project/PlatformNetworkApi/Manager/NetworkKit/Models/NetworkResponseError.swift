import VCNetworkKit

struct NetworkResponseError: Error {
    
    // MARK: - Properties
    var error: Error
    var httpResponse: HttpResponse?
    
}
