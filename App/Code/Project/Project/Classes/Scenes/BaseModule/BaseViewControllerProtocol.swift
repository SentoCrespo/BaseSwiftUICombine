import Foundation
import SharedUtils

protocol BaseViewControllerProtocol: LoadingHud {
    func show(error: Error)
}
