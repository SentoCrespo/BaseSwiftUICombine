import Foundation

import Domain
import SharedUtils
import UIKit

// MARK: - Navigator

class SignupNavigator {
    private let navigationController: UINavigationController
    private let configurator: SignupConfigurator
    
    init(configurator: SignupConfigurator, navigationController: UINavigationController) {
        self.configurator = configurator
        self.navigationController = navigationController
    }
}

// MARK: In

extension SignupNavigator {
    func toView() {
        let vc: SignupViewController = UIStoryboard.instantiateInitialViewController()
        vc.presenter = SignupPresenter(configurator: self.configurator, navigator: self, view: vc)
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: Out

extension SignupNavigator {
    func showNext() {
        // TODO:
    }
}
