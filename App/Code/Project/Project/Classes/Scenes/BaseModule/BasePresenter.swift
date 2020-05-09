import Foundation
import UIKit
import Combine

public class BasePresenter {
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    public init(view: UIViewController) {
        self.handleLifeCycle(view: view)
    }
    
    // MARK: - Life Cycle Overrides
    func viewDidLoad() {}
    
    func viewWillAppear(animated: Bool) {}
    
    func viewDidAppear(animated: Bool) {}
    
    func viewWillDisappear(animated: Bool) {}
    
    func viewDidDisappear(animated: Bool) {}
    
}

private extension BasePresenter {
    
    func handleLifeCycle(view: UIViewController) {
        
        // TODO: Implement with Combine?
        
//        view
//            .rx
//            .viewDidLoad
//            .subscribe(onNext: { [weak self] in
//                self?.viewDidLoad()
//            })
//            .disposed(by: self.disposeBag)
//
//        view
//            .rx
//            .viewWillAppear
//            .subscribe(onNext: { [weak self] animated in
//                self?.viewWillAppear(animated: animated)
//            })
//            .disposed(by: self.disposeBag)
//
//        view
//            .rx
//            .viewDidAppear
//            .subscribe(onNext: { [weak self] animated in
//                self?.viewDidAppear(animated: animated)
//            })
//            .disposed(by: self.disposeBag)
//
//        view
//            .rx
//            .viewWillDisappear
//            .subscribe(onNext: { [weak self] animated in
//                self?.viewWillDisappear(animated: animated)
//            })
//            .disposed(by: self.disposeBag)
//
//        view
//            .rx
//            .viewDidDisappear
//            .subscribe(onNext: { [weak self] animated in
//                self?.viewDidDisappear(animated: animated)
//            })
//            .disposed(by: self.disposeBag)
    }
}

import Domain

// TODO: Implement with Combine

//extension BasePresenter {
//
//    typealias AsyncOperationHasContent = () -> Bool
//    func asyncOperation<T>(
//        observable: Observable<SuccessResponse<T>>,
//        view: BaseViewControllerProtocol?,
//        hasContent: AsyncOperationHasContent = { return true }) -> Observable<SuccessResponse<T>> {
//        let result = Observable
//            .just(Empty.empty)
//            .map { _ in
//                view?.showLoadingDialog()
//            }
//            .flatMap { _ -> Observable<SuccessResponse<T>> in
//                return observable
//            }
//            .do(
//                onError: { error in
//                    view?.show(error: error)
//                },
//                onDispose: {
//                    view?.hideLoadingDialog()
//            })
//        return result
//    }
//
//    func asyncOperationData<T: Codable & Hashable>(observable: Observable<T>, view: BaseViewControllerProtocol?) -> Observable<T> {
//        let result = Observable
//            .just(Empty.empty)
//            .map { _ in
//                view?.showLoadingDialog()
//            }
//            .flatMap { _ -> Observable<T> in
//                return observable
//            }
//            .do(onError: { error in
//                view?.show(error: error)
//            }, onDispose: {
//                view?.hideLoadingDialog()
//            })
//
//        return result
//    }
//}
