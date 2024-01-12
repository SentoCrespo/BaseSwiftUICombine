import Foundation
import Combine

/// Binding between UI and business logic
class MainViewModel: BaseViewModel<MainModel>, ObservableObject {
    
    required init(configurator: SceneConfigurator) {
        super.init(configurator: configurator)
        
    }
     
    // MARK: - Handle effect
    override func handle(effect: MainModel.Effect) {
        // TODO: Replace with Logger
        print("Processing effect: \(effect)")
        switch effect {
        case .loadItems:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.apply(event: .onLoadingSuccess("Result"))
            }
        case .removeItem:
            // TODO: Replace with Logger
            print("Remove Item")
        case .navigateToProfile:
            // TODO: Replace with Logger
            print("Navigate to profile effect")
        }
    }
    
    override func handle(event: MainModel.Event) {
        // TODO: Replace with Logger
        print("Processing event: \(event)")
//        switch event {
//            case .onAppear:
//                break
//        }
    }
    
}

// MARK: - Public Methods
extension MainViewModel {

}
