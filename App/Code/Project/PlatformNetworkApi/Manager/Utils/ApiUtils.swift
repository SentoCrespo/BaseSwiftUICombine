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

// class ApiUtils {
//
//    static func apiRequest<T: Decodable>(networkService: NetworkService, request: Request, logger: Logger) -> Observable<SuccessResponse<T>> {
//
//        return Observable.create { observable in
//
//            let cancellableRequest = networkService.request(
//                request,
//                log: { logText in
//
//                    logger.debug(logText)
//
//            }, completion: { (networkResponse: NetworkResponse<ApiResponse<T>?>) in
//
//                switch networkResponse {
//
//                case .success(let apiResponse, let httpResponse):
//                    guard let apiResponse = apiResponse else {
//                        let errorResponse = ErrorResponse.noData(statusCode: httpResponse.responseCode)
//                        observable.onError(errorResponse)
//                        return
//                    }
//
//                    observable.onNext(SuccessResponse(data: apiResponse.object, responseCode: apiResponse.responseCode, statusCode: httpResponse.responseCode))
//                    observable.onCompleted()
//
//                case .networkError(let responseError, let httpResponse):
//
//                    logger.error("* Network error: \(responseError)")
//
//                    do {
//                        guard var errorResponse = try ErrorResponse.parse(from: httpResponse.data) else {
//                            let error = ErrorResponse.encoding(statusCode: httpResponse.responseCode)
//                            observable.onError(error)
//                            return
//                        }
//                        errorResponse.statusCode = httpResponse.responseCode
//                        observable.onError(errorResponse)
//                    } catch {
//                        let error = ErrorResponse.encoding(statusCode: httpResponse.responseCode)
//                        observable.onError(error)
//                    }
//
//                case .encodingError(let error):
//
//                    logger.error("* Encoding error: \(error)")
//
//                    let errorResponse = ErrorResponse.encoding()
//                    observable.onError(errorResponse)
//
//                }
//            })
//
//            return Disposables.create {
//                cancellableRequest()
//            }
//
//        }
//
//    }
//
//    static func downloadRequest(networkService: NetworkService, request: Request, logger: Logger) -> Observable<Data> {
//        return Observable.create { observable in
//
//            let cancellableRequest = networkService.request(
//                request,
//                log: { logger.debug($0) }) { (networkResponse: NetworkResponse<Data?>) in
//
//                    switch networkResponse {
//                    case .success(.some(let data), _):
//                        observable.onNext(data)
//                        observable.onCompleted()
//                    case .success:
//                        observable.onError(ErrorResponse.noData())
//                    case .networkError(let responseError, let httpResponse):
//                        logger.error("* Network error: \(responseError)")
//                        let error = ErrorResponse.encoding(statusCode: httpResponse.responseCode)
//                        observable.onError(error)
//
//                    case .encodingError(let error):
//                        logger.error("* Encoding error: \(error)")
//
//                        let errorResponse = ErrorResponse.encoding()
//                        observable.onError(errorResponse)
//
//                    }
//            }
//
//            return Disposables.create {
//                cancellableRequest()
//            }
//
//        }
//    }
//
// }

extension ErrorResponse {
    static func encoding(statusCode: Int = 9999) -> ErrorResponse {
        return ErrorResponse(statusCode: statusCode)
    }
    
    static func noData(statusCode: Int = 9999) -> ErrorResponse {
        return ErrorResponse(statusCode: statusCode)
    }
}
