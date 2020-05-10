import Foundation

import Domain
import PRSharedUtils
import UIKit

// MARK: - Navigator

class BlankNavigator {
    // MARK: - Properties
    
    private let navigationController: UINavigationController
    private let configurator: BlankConfigurator
    
    // MARK: - Life Cycle
    
    init(configurator: BlankConfigurator, navigationController: UINavigationController) {
        self.configurator = configurator
        self.navigationController = navigationController
    }
}

// MARK: - In

extension BlankNavigator {
    func toView() {
        let vc: BlankViewController = UIStoryboard.instantiateInitialViewController()
        vc.presenter = BlankPresenter(configurator: self.configurator, navigator: self, view: vc)
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: - Out

extension BlankNavigator {}
