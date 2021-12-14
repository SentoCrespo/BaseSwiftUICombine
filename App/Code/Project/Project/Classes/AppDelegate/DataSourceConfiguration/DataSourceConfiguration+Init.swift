import Domain
import Foundation
import PlatformNetworkApi
import PlatformNetworkStatic
import UseCases

// MARK: User

extension DataSourceConfiguration {
    
    static func userApi(environment: ApiEnvironment) -> UseCases.UserDataSource {
        return PlatformNetworkApi.UseCasesUsersDataSource(environment: environment)
    }
    
    static func userStatic(responseType: ResponseType, delay: DispatchTimeInterval) -> PlatformNetworkStatic.UseCasesUsersDataSource {
        return PlatformNetworkStatic.UseCasesUsersDataSource(
            responseType: responseType,
            delay: delay
        )
    }
    
}
