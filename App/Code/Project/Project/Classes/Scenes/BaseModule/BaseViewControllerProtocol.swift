import Foundation
import PRSharedUtils

protocol BaseViewControllerProtocol: LoadingHud {
    func show(error: Error)
}
