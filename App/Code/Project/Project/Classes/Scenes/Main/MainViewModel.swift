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
        switch effect {
        case .loadItems:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.apply(event: .onLoadingSuccess("Result"))
            }
        case .removeItem:
            Logger.app.debug("Remove Item")
        case .navigateToProfile:
            Logger.app.debug("Navigate to profile effect")
        }
    }
    
    override func handle(event: MainModel.Event) {
        switch event {
            case .start:
                break
            case .onAppear:
                break
            case .onLoadingFailed(let error):
                Logger.app.error("\(error)")
            case .onLoadingSuccess(let data):
                Logger.app.debug("Loading success")
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
