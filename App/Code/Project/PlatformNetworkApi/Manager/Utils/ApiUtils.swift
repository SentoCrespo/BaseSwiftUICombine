import Domain
import Foundation
import Combine

struct Agent {
    // 1
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    // 2
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data) // 4
                return Response(value: value, response: result.response) // 5
            }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
    }
}

extension ErrorResponse {
    static func encoding(statusCode: Int = 9999) -> ErrorResponse {
        return ErrorResponse(statusCode: statusCode)
    }
    
    static func noData(statusCode: Int = 9999) -> ErrorResponse {
        return ErrorResponse(statusCode: statusCode)
    }
}
