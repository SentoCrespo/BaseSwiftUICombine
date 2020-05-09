import Foundation
import Domain
import Combine

final class SignupPresenter: BasePresenter {
    
    // MARK: - Properties
    fileprivate let configurator: SignupConfigurator
    fileprivate let navigator: SignupNavigator
    fileprivate weak var view: SignupViewController?
    
    // MARK: - Life Cycle
    init(configurator: SignupConfigurator, navigator: SignupNavigator, view: SignupViewController) {
        self.configurator = configurator
        self.navigator = navigator
        self.view = view
        
        super.init(view: view)
    }
    
}

// MARK: - Public Methods
extension SignupPresenter {
    func onSignUp(username: String?, password: String?, repeatPassword: String?) {
        guard let username = username else {
            Log.error("No username found")
            return
        }
        guard let password = password else {
            Log.error("No password found")
            return
        }
        guard let repeatPassword = repeatPassword else {
            Log.error("No repeatPassword found")
            return
        }
        
        let opSignup = UseCasesUser
            .signup(
                username: username,
                password: password,
                repeatPassword: repeatPassword,
                dataSource: self.configurator.dataSource.user
        )
        // TODO: Implement with Combine
//        self.asyncOperation(observable: opSignup, view: self.view)
//            .subscribe(
//                onNext: { [weak self] response in
//                    Log.debug("Response \(response.data)")
//                    self?.navigator.showNext()
//            })
//            .disposed(by: disposeBag)
    }
}

// MARK: - Private Methods

extension SignupPresenter {}
