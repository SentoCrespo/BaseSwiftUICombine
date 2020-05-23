import Foundation
import Combine

/// Binding between UI and business logic
class MainViewModel: BaseViewModel<MainModel>, ObservableObject {
    
    required init(configurator: SceneConfigurator) {
        super.init(configurator: configurator)
        
    }
    
    // MARK: - Handle effect
    override func handle(effect: MainModel.Effect) {
        Log.debug("Processing effect: \(effect)")
        switch effect {
        case .loadItems:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.apply(event: .onLoadingSuccess("Result"))
            }
        case .navigateToProfile:
            Log.debug("Navigate to profile effect")
        }
    }
    
}

// MARK: - Public Methods
extension MainViewModel {

}
