import Domain
import Foundation
import Combine
import PRSharedUtils
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: Outlets
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initViewController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: Initialization
    func initViewController() {
        self.translation()
        self.initUI()
    }
    
    func translation() {}
    
    func initUI() {
        self.view.backgroundColor = .main
        self.navigationController?.navigationBar.barStyle = .black
        
        // self.placeLogoInNavigationBar()
    }
    
    func show(error: Error) {
        Log.error("Show error: \(error)")
        
        if let errorResponse = error as? ErrorResponse {
            let errorMessage = "Temporary unavailable"
            self.showError(text: "\(errorResponse) \(errorMessage)")
            return
        }
        
        guard let prError = error as? PRError else {
            Log.error("Not treating error: \(error)")
            return
        }
        
        switch prError {
        default:
            Log.error("PRError not treated: \(error)")
            self.showError(text: "Temporary unavailable") // TODO: Translate
        }
    }
    
    func showError(text: String, title: String = "GLOBAL_ERROR_TITLE") {
        // TODO:
        Log.error(text)
    }
    
}

extension BaseViewController: BaseViewControllerProtocol {}
