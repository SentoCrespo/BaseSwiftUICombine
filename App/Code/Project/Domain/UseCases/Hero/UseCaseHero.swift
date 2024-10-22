import Foundation
import Combine

public enum UseCaseHeroes {}

// MARK: - Public Methods
public extension UseCaseHeroes {
    
    static func heroes(dataSource: UseCaseHeroDataSource) -> AnyPublisher<[Hero], Error> {
        // Do any additional logic / validation if needed
        return dataSource.getHeroes()
    }

}
