import UIKit

import Domain
import Combine
import SharedUtils

class SignupViewController: BaseViewController {
    // MARK: - Properties
    
    var presenter: SignupPresenter!
    
    // MARK: - Outlets
    
    @IBOutlet var tfUser: PRTextField!
    @IBOutlet var tfPassword: PRTextField!
    @IBOutlet var tfPasswordRepeat: PRTextField!
    @IBOutlet var btAction: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Initialization
    
    override func translation() {
        self.title = "Signup" // FIXME: Translate
        
        self.tfUser.placeholder = "Username" // FIXME: Translate
        self.tfPassword.placeholder = "Password" // FIXME: Translate
        self.tfPasswordRepeat.placeholder = "Password Repeat" // FIXME: Translate
        self.btAction.setTitle("Sign Up", for: .normal) // FIXME: Translate
    }
    
    override func initUI() {
        super.initUI()
        
        self.configureBtAction()
    }
}

// MARK: - Public methods

extension SignupViewController {}

// MARK: - Private methods

private extension SignupViewController {
    func configureBtAction() {
        // TODO: With Combine
        
//        self.btAction
//            .rxTap { [weak self] in
//                let username = self?.tfUser.text
//                let password = self?.tfPassword.text
//                let repeatPassword = self?.tfPasswordRepeat.text
//                self?.presenter?.onSignUp(username: username, password: password, repeatPassword: repeatPassword)
//            }
//            .disposed(by: self.disposeBag)
    }
}
