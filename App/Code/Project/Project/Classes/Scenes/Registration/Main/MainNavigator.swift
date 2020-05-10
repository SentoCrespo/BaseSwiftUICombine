import Foundation

import Domain
import PRSharedUtils
import UIKit

// MARK: - Navigator

class MainNavigator {
    private let navigationController: UINavigationController
    private let configurator: MainConfigurator
    
    init(configurator: MainConfigurator, navigationController: UINavigationController) {
        self.configurator = configurator
        self.navigationController = navigationController
    }
}

// MARK: In
extension MainNavigator {
    func toView() {
        let vc: MainViewController = UIStoryboard.instantiateInitialViewController()
        vc.presenter = MainPresenter(
            configurator: self.configurator,
            navigator: self,
            view: vc
        )
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: Out
extension MainNavigator {

    func toSignup() {
        let configurator = SignupConfigurator(
            dataSource: AppDelegate.shared.datasource!
        )
        let navigator = SignupNavigator(
            configurator: configurator,
            navigationController: self.navigationController
        )
        navigator.toView()
    }

}
