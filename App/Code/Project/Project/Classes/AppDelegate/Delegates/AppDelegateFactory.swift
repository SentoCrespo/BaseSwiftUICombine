import Foundation

enum AppDelegateFactory {

    // MARK: - Properties
    
    // MARK: - Life Cycle
    
}

// MARK: - Public Methods
extension AppDelegateFactory {
    
    static func makeDefault() -> AppDelegateType {
        return CompositeAppDelegate(
            appDelegates: [
                AppDelegateThirdParty(),
                AppDelegateDebug(),
                AppDelegateConfigurations(),
                AppDelegateRemoteNotifications(),
                AppDelegateStartup()
            ]
        )
    }
    
    static func makeTest() -> AppDelegateType {
        return CompositeAppDelegate(
            appDelegates: [
                AppDelegateMock()
            ]
        )
    }
    
}
