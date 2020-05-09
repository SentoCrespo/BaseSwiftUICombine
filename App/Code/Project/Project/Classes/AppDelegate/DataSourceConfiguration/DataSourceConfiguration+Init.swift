import Domain
import Foundation
import PlatformNetworkApi
import PlatformNetworkStatic

// MARK: User

extension DataSourceConfiguration {
    
    static func userApi(environment: ApiEnvironment) -> Domain.UseCasesUsersDataSource {
        return PlatformNetworkApi.UseCasesUsersDataSource(environment: environment)
    }
    
    static func userStatic(responseType: ResponseType, delay: DispatchTimeInterval) -> PlatformNetworkStatic.UseCasesUsersDataSource {
        return PlatformNetworkStatic.UseCasesUsersDataSource(
            responseType: responseType,
            delay: delay
        )
    }
    
}
