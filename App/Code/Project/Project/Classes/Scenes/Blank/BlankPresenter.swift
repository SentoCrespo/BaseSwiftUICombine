import Foundation

import Domain

import RxCocoa
import RxSwift

final class BlankPresenter: BasePresenter {
    // MARK: - Properties
    
    fileprivate let configurator: BlankConfigurator
    fileprivate let navigator: BlankNavigator
    fileprivate weak var view: BlankViewController?
    
    // MARK: - Life Cycle
    
    init(configurator: BlankConfigurator, navigator: BlankNavigator, view: BlankViewController) {
        self.configurator = configurator
        self.navigator = navigator
        self.view = view
        
        super.init(view: view)
    }
}

// MARK: - Public Methods

extension BlankPresenter {}

// MARK: - Private Methods

extension BlankPresenter {}
