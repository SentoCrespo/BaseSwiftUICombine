import Foundation
import VCNetworkKit

// MARK: - URL Request
public extension Request {

    typealias UrlRequestResult = Result<URLRequest, NetworkServiceUrlSessionError>
    /// Transforms a request into a UrlRequest
    func urlRequest(baseUrl: URL?) -> UrlRequestResult {
        
        // Calculate the complete Url depending on the type
        let finalUrl: URL
        switch self.url {
        case .endpoint:
            guard let baseUrl = baseUrl else {
                return .failure(.noBaseUrl)
            }
            finalUrl = self.fullUrl(baseUrl: baseUrl)
        case .full(let url):
            finalUrl = url
        }
        
        // Split the logic between a request and a multipart upload
        switch self.type {
        case .uploadMultipartData:
            return .failure(.badRequestType)
        case .request(let parameters, let parametersEncoding):
            return self.urlRequest(
                url: finalUrl,
                parameters: parameters,
                parametersEncoding: parametersEncoding)
        }
        
    }
    
}

// MARK: - Url Request
private extension Request {
    
    func urlRequest(url: URL,
                    parameters: HttpParameters?,
                    parametersEncoding: ParametersEncoding) -> UrlRequestResult {
        
        // Create the UrlRequest from the given request
        var urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData, // TODO: As property if needed
            timeoutInterval: self.timeout
        )
        
        // Process Method
        let urlRequestMethod = self.method.urlRequestMethod
        urlRequest.httpMethod = urlRequestMethod
        
        // Process parameters if they're present
        if let parameters = parameters, parameters.isEmpty == false {
            switch parametersEncoding {
            case .url:
                guard var urlComponents = URLComponents(
                    url: url,
                    resolvingAgainstBaseURL: false) else {
                        return .failure(.urlEncodingParameters)
                }
                let queryItems: [URLQueryItem] = parameters.map { key, value in
                    return URLQueryItem(name: key, value: "\(value)")
                }
                urlComponents.queryItems = queryItems
                urlRequest.url = urlComponents.url
            case .json:
                let jsonData = try? JSONSerialization.data(
                    withJSONObject: parameters,
                    options: []
                )
                guard let jsonParameters = jsonData else {
                    return .failure(.jsonEncodingParameters)
                }
                urlRequest.httpBody = jsonParameters
                // Add application/json header
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
        
        // Process headers if they're present
        if let headers = self.headers, headers.isEmpty == false {
            headers.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return .success(urlRequest)
        
    }
    
}
