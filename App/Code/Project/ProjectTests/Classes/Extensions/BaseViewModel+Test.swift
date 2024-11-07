@testable import Project
import Foundation

extension BaseViewModel {
    
    func applyBlocking(event: Model.Event) -> TransitionOutput {
        self.apply(event: event)
        RunLoop.main.run(mode: .default, before: .distantPast)
        return self.output
    }
    
}
