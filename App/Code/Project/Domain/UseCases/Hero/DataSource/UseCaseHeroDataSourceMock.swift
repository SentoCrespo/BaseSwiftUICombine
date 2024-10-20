import Foundation
import Combine

public class UseCaseHeroDataSourceMock {
    
    // MARK: - Properties
    private var resultGetHeroes: Result<[Hero], Error>!
    
    // MARK: - Life Cycle
    public init() {}
    
}

// MARK: - Public Methods
public extension UseCaseHeroDataSourceMock {
    
    func withGetHeroes(_ result: Result<[Hero], Error>) -> Self {
        self.resultGetHeroes = result
        return self
    }
    
}

extension UseCaseHeroDataSourceMock: UseCaseHeroDataSource {
    
    public func getHeroes() -> AnyPublisher<[Hero], Error> {
        switch resultGetHeroes! {
            case .success(let heroes):
                return Just(heroes)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
                
            case .failure(let error):
                return Fail(error: error)
                    .eraseToAnyPublisher()
        }
    }
    
}
