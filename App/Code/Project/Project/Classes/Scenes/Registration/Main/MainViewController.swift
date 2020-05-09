import UIKit

import Domain
import Combine
import SharedUtils

class MainViewController: BaseViewController {
    // MARK: - Properties
    
    var presenter: MainPresenter!
    
    // MARK: - Outlets
    
    @IBOutlet var lbLogin: UILabel!
    @IBOutlet var btLogin: UIButton!
    @IBOutlet var btSignup: UIButton!
    @IBOutlet var btFacebook: UIButton!
    @IBOutlet var btGoogle: UIButton!
    
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
        self.title = ""
    }
    
    override func initUI() {
        super.initUI()
        
        self.configureBtSignup()
        self.configureBtFacebook()
        self.configureBtGoogle()
    }
}

// MARK: - Public methods

extension MainViewController {}

// MARK: - Private methods

private extension MainViewController {
    func configureBtSignup() {
        // TODO: With Combine
//        btSignup
//            .rxTap { [weak self] in
//                self?.presenter?.onBtSignup()
//            }
//            .disposed(by: self.disposeBag)
    }
    
    func configureBtFacebook() {
        // TODO: With Combine
//        btFacebook
//            .rxTap { [weak self] in
//                self?.presenter?.onBtFacebook()
//            }
//            .disposed(by: self.disposeBag)
    }
    
    func configureBtGoogle() {
        // TODO: With Combine
//        btGoogle
//            .rxTap { [weak self] in
//                self?.presenter?.onBtGoogle()
//            }
//            .disposed(by: self.disposeBag)
    }
}
