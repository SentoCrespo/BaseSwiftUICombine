import Foundation

public enum UrlSessionError: Error {
    case noBaseUrl
    case badRequestType
    case urlEncodingParameters
    case jsonEncodingParameters
    case multipartEncoding
    case statusCode(Int)
}
