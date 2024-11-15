import Foundation

enum SceneDelegateFactory {

    // MARK: - Properties
    
    // MARK: - Life Cycle
    
}

// MARK: - Public Methods
extension SceneDelegateFactory {
    
    @MainActor
    static func makeDefault() -> SceneDelegateType {
        return CompositeSceneDelegate(
            sceneDelegates: [
                SceneDelegateThirdParty(),
                SceneDelegateDebug(),
                SceneDelegateConfigurations(),
                SceneDelegateDeeplinks(),
                SceneDelegateRemoteNotifications(),
                SceneDelegateStartup()
            ]
        )
    }
    
    @MainActor
    static func makeTest() -> SceneDelegateType {
        return CompositeSceneDelegate(
            sceneDelegates: [
                SceneDelegateMock(),
                SceneDelegateConfigurations()
            ]
        )
    }
    
}
