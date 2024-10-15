import Foundation
import Combine

public class UseCaseHeroDataSourceRemote: UseCaseHeroDataSource {
    
    struct HeroResponseAPI: Codable {
        let superheroes: [Hero]
    }
    
    // MARK: - Properties
    private let url: URL
    
    // MARK: - Life Cycle
    public init(url: URL) {
        self.url = url
    }
    
}

// MARK: - Public Methods
public extension UseCaseHeroDataSourceRemote {
    
    func getHeroes() -> AnyPublisher<[Hero], Error> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: HeroResponseAPI.self, decoder: JSONDecoder())
            .map { $0.superheroes }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
