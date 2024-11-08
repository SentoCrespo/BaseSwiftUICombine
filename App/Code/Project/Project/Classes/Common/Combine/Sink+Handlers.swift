import Foundation
import Combine

extension Publisher {
    
    func sink(
        receiveValue: ((Output) -> Void)? = nil,
        receiveError: ((Failure) -> Void)? = nil,
        receiveCompletion: ((Bool) -> Void)? = nil
    ) -> Cancellable {
        
        return self.sink(
            receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        receiveCompletion?(true)
                    case .failure(let error):
                        receiveError?(error)
                        receiveCompletion?(false)
                }
            },
            receiveValue: { value in
                receiveValue?(value)
            }
        )
    }
    
}
