import Foundation

public enum NetworkServiceUrlSessionError: Error {
    case noBaseUrl
    case badRequestType
    case urlEncodingParameters
    case jsonEncodingParameters
    case multipartEncoding
}
