import Foundation
import Combine

import Domain

final class MainPresenter: BasePresenter {
    // MARK: - Properties
    
    fileprivate let configurator: MainConfigurator
    fileprivate let navigator: MainNavigator
    fileprivate weak var view: MainViewController?
    
    // MARK: - Life Cycle
    
    init(configurator: MainConfigurator, navigator: MainNavigator, view: MainViewController) {
        self.configurator = configurator
        self.navigator = navigator
        self.view = view
        
        super.init(view: view)
    }
}

// MARK: - Public Methods

extension MainPresenter {
    func onBtSignup() {
        self.navigator.toSignup()
    }
    
    func onBtFacebook() {
        let token = "TODO: Get the token"
//        let opLoginFb = UseCasesUser.loginWithFacebook(
//            token: token,
//            dataSource: self.configurator.dataSource.user
//        )
        // TODO: Implement with Combine
//        self.asyncOperation(observable: opLoginFb, view: self.view)
//            .subscribe(
//                onNext: { [weak self] user in
//                    Log.verbose("User received: \(user)")
//                    self?.navigator.toMenu()
//            })
//            .disposed(by: self.disposeBag)
    }
    
    func onBtGoogle() {
        let token = "TODO: Get the token"
//        let opLoginGoogle = UseCasesUser.loginWithGoogle(
//            token: token,
//            dataSource: self.configurator.dataSource.user)
        // TODO: Implement with Combine
//        self.asyncOperation(observable: opLoginGoogle, view: self.view)
//            .subscribe(
//                onNext: { [weak self] user in
//                    Log.verbose("User received: \(user)")
//                    self?.navigator.toMenu()
//            })
//            .disposed(by: self.disposeBag)
    }
}

// MARK: - Private Methods

extension MainPresenter {}
