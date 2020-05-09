import Domain
import Foundation

public enum ApiEnvironment: String {
    case debug = "Debug"
    case integration = "Integration"
    case demo = "Demo"
    case production = "Production"
}

public class BaseUseCaseDataSource {
    // MARK: - Properties
    
    // TODO:
//    private let networkService: NetworkService
    
    // MARK: - Life Cycle
    
    public init(environment: ApiEnvironment) {
        let baseUrl: URL
        switch environment {
        case .debug:
            baseUrl = URL(string: "http://192.168.0.1")!
        case .integration:
            baseUrl = URL(string: "https://nube000.muving.com/RestAPI/RestServices")!
        case .demo:
            baseUrl = URL(string: "https://nube000.muving.com/RestAPI/RestServices")!
        case .production:
            baseUrl = URL(string: "https://nube000.muving.com/RestAPI/RestServices")!
        }
        
        // TODO:
//        self.networkService = AlamofireService(baseUrl: baseUrl)
    }
}
