import Foundation
import Combine

public protocol UseCaseHeroDataSource {
    func getHeroes() -> AnyPublisher<[Hero], Error>
}
