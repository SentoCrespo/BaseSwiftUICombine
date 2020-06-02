import Foundation
import VCNetworkKit

// MARK: - Multipart Upload
public extension Request {
    
    typealias UploadRequestResult = Result<NetworkServiceMultipartRequest, NetworkServiceUrlSessionError>
    /// Transforms a request into a uploadRequest
    func uploadRequest(baseUrl: URL?) -> UploadRequestResult {
        
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
        
        case .request:
            return .failure(.badRequestType)
            
        case .uploadMultipartData(let parameters):
            
            // Create a boundary
            let boundary = UUID().uuidString
            
            let urlRequest: URLRequest = self.createUploadRequestUrl(
                url: finalUrl,
                parameters: parameters,
                boundary: boundary
            )
            
            guard let bodyData: Data = self.createUploadRequestData(
                parameters: parameters,
                boundary: boundary
                ) else {
                    return .failure(.multipartEncoding)
            }
            
            let result = NetworkServiceMultipartRequest(
                urlRequest: urlRequest,
                bodyData: bodyData
            )
            
            return .success(result)
        }
        
    }
    
}

private extension Request {
    
    func createUploadRequestUrl(url: URL,
                                parameters: [[String: MultipartParameter]],
                                boundary: String) -> URLRequest {
        
        // Create the UrlRequest from the given request
        var urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData, // TODO: As property if needed
            timeoutInterval: self.timeout
        )
        
        // Process Method
        let urlRequestMethod = self.method.urlRequestMethod
        urlRequest.httpMethod = urlRequestMethod
        
        // Add multipart/form-data header
        let contentTypeheader = [
            "multipart/form-data;",
            "boundary=\(boundary)"
            ].joined(separator: " ")
        urlRequest.setValue(contentTypeheader, forHTTPHeaderField: "Content-Type")
        
        // Process headers if they're present
        if let headers = self.headers, headers.isEmpty == false {
            headers.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return urlRequest
    }
    
    func createUploadRequestData(parameters: [[String: MultipartParameter]],
                                 boundary: String) -> Data? {
        
        // Process parameters
        var bodyData = Data()
        
        parameters.forEach { parameter in
            parameter.forEach { (key, value) in
                var bodyString = ""
                // Boundary
                bodyString += [
                    "\r\n",
                    "--\(boundary)",
                    "\r\n"
                    ]
                    .joined(separator: "")
                
                // Name
                bodyString += [
                    "Content-Disposition: form-data;",
                    " ",
                    "name=\"\(key)\";",
                    " ",
                    "filename=\"\(value.fileParameter?.fileName ?? "")\"",
                    "\r\n"
                    ]
                    .joined()
                
                // Mime Type
                bodyString += [
                    "Content-Type: \(value.fileParameter?.mimeType ?? "")",
                    "\r\n\r\n"
                    ].joined()
                   
                // Convert to Data
                bodyData = bodyString.data(using: .utf8)! // FIXME: Throw
                
                // Append binary data
                bodyData.append(value.data)
            }
        }
        
        // End the raw http request data, note that there is 2 extra dash ("-")
        // at the end, this is to indicate the end of the data
        // According to the HTTP 1.1 specification
        // https://tools.ietf.org/html/rfc7230
        bodyData.append([
            "\r\n--",
            "\(boundary)",
            "--\r\n"
            ]
            .joined()
            .data(using: .utf8)!)
        
        return bodyData
    }
    
}
