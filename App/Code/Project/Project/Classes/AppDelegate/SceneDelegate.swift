import Foundation
import UIKit

@UIApplicationMain
class SceneDelegate: UIResponder {
    
    // MARK: - Properties
    var window: UIWindow?
    // swiftlint:disable:next weak_delegate
    var sceneDelegate = SceneDelegateFactory.makeDefault()
    
}

// MARK: Global Variables
import Log
var Log: Logger {
    let delegate = SceneDelegate
        .shared
        .compositeDelegate?
        .delegate(
            type: SceneDelegateThirdParty.self
    )
    return delegate?.logger ?? ConsoleLogger()
}

// MARK: Computed Variables
extension SceneDelegate {
    
    static var shared: SceneDelegate {
        return UIApplication.shared.delegate as? SceneDelegate ?? SceneDelegate()
    }
    
    var compositeDelegate: CompositeSceneDelegate? {
        return SceneDelegate.shared.sceneDelegate as? CompositeSceneDelegate
    }

    var datasource: DataSourceConfiguration? {
        let delegate = compositeDelegate?.delegate(type: SceneDelegateConfigurations.self)
        return delegate?.dataSourceConfiguration
    }
    
}