import VCNetworkKit

extension HttpResponse {
    
    init(httpUrlResponse: HTTPURLResponse, url: URL, data: Data?) {
        self.init(
            responseCode: httpUrlResponse.statusCode,
            data: data ?? Data(),
            url: httpUrlResponse.url ?? url,
            headerFields: httpUrlResponse.allHeaderFields as? [String: String]
        )
    }
    
}

