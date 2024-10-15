import Foundation
import Combine

public class UseCaseHeroDataSourceLocal: UseCaseHeroDataSource {
    
    // MARK: - Properties
    private let filename: String
    
    // MARK: - Life Cycle
    public init(filename: String) {
        self.filename = filename
    }
    
}

// MARK: - Public Methods
public extension UseCaseHeroDataSourceLocal {
    
    struct HeroResponseLocal: Codable {
        let superheroes: [Hero]
    }
    
    func getHeroes() -> AnyPublisher<[Hero], Error> {
        Future { promise in
            guard let url = Bundle(for: UseCaseHeroDataSourceLocal.self).url(forResource: self.filename, withExtension: "json") else {
                promise(.failure(NSError(domain: "File not found", code: -1, userInfo: nil)))
                return
            }
            guard let data = try? Data(contentsOf: url) else {
                promise(.failure(NSError(domain: "Content not found", code: -2, userInfo: nil)))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(HeroResponseLocal.self, from: data)
                promise(.success(decodedData.superheroes))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
