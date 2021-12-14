import VCNetworkKit
import PRSharedUtils

public enum ApiEnvironment: String {
    case debug = "Debug"
    case integration = "Integration"
    case demo = "Demo"
    case production = "Production"
}

public class BaseUseCaseDataSource {
    
    // MARK: - Properties
    private let networkService: NetworkServiceCombine
    
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
        
        self.networkService = NetworkServiceCombine(
            baseUrl: baseUrl,
            session: URLSession.shared,
            isDebugMode: UIDevice.isSimulator
        )
        
    }
}
