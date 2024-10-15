import Foundation
import Combine

public enum HeroesUseCase {}

// MARK: - Public Methods
public extension HeroesUseCase {
    
    static func heroes(dataSource: UseCaseHeroDataSource) -> AnyPublisher<[Hero], Error> {
        // Do any additional logic / validation if needed
        return dataSource.getHeroes()
    }

}

//class HeroRepository {
//    private var cancellables = Set<AnyCancellable>()
//    
//    func fetchHeroes(from dataSource: UseCaseHeroDataSource) {
//        dataSource.getHeroes()
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    print("Success")
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }, receiveValue: { heroes in
//                print(heroes)
//            })
//            .store(in: &cancellables)
//    }
//}
//
//// Uso con fichero local
//let localDataSource = LocalHeroDataSource(filename: "Heroes")
//let heroRepository = HeroRepository()
//heroRepository.fetchHeroes(from: localDataSource)
//
//// Uso con API remota
//let remoteDataSource = RemoteHeroDataSource(url: URL(string: "https://miapi.com/heroes")!)
//heroRepository.fetchHeroes(from: remoteDataSource)

/*
 
 This is a sample app, not production-ready code.There are lots of room for improvement like:
 
 1. Improve the architecture
    1.1. Create independent targets for:
        - DataSource ~> API
        - DataSource ~> Static/Mock
    1.2. Define a class/framework for dealing with data requests in a common way
    1.3. Include a Changelog for releases
 
 2 Improve the code
    2.1. Use async/await
    2.2. Define specific errors if needed to:
        - Display better information to the user
        - Easier debugging
    2.3. Use more complex data set, with different types, not just strings
 
 4. Improve the UI/UX:
    - Although the scene/module architecture is well-defined
    - Create a Navigation pattern and mechanism
    - Deeplinks
    - Notifications
    - Translations
    - Localization (distances, weight, currencies, ...)
    - Etc.
    
 5. Better awareness and bug-fixing:
    - The project already includes swiftlint
    - Include tools like Crashlytics
    - Gather metrics to analyze how users interact with the app
    - Include A/B testing
    - Feature flag
    - Dynamic configuration, on-the-fly for a fast response if a service or a feature suddenly gets interrupted or fails
 
 6. Define a pipeline for releasing new versions with every step automated
    - Certificates & provisioning profiles creation
    - Run tests before the release
    - Notify (Slack, Jira, ...)
    - Automatic upload to Testflight or AdHoc distribution
    - ...
    
 
 7. Include other tests, specially, UI automations for core flows and functionality that run periodically and before every release
  
 */
