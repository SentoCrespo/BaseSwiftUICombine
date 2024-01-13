import Foundation
import Combine

/// Binding between UI and business logic
class MainViewModel: BaseViewModel<MainConfigurator, MainModel, MainRender>, ObservableObject {
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    required init(render: MainRender, configurator: MainConfigurator) {
        super.init(render: render, configurator: configurator)
        
    }
    
    deinit {
        self.disposeBag.removeAll()
    } 
    
    // MARK: - Handle effect
    override func handle(effect: MainModel.Effect) {
        Logger.shared.debug("Processing effect: \(effect)")
        switch effect {
        case .loadItems:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.apply(event: .onLoadingSuccess("Result"))
            }
        case .removeItem:
            Logger.shared.debug("Remove Item")
        case .navigateToProfile:
            Logger.shared.debug("Navigate to profile effect")
        }
    }
    
    override func handle(event: MainModel.Event) {
        Logger.shared.debug("Processing event: \(event)")
        switch event {
            case .start:
                break
            case .onAppear:
                break
            case .onLoadingFailed(let error):
                break
            case .onLoadingSuccess(let data):
                break
            case .onReload:
                break
            case .onSelect(let item):
                break
            case .onSwipe(let item):
                break
        }
    }
    
}

// MARK: - Public Methods
extension MainViewModel {
    
}
