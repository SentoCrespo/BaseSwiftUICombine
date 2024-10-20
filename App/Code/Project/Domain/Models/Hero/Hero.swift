import Foundation

public struct Hero {

    // Not decoding the id
    public let id = UUID()
    public var name: String
    public var photo: String
    public var realName: String
    public var height: String
    public var power: String
    public var abilities: String
    public var groups: String

}

extension Hero: Equatable, Hashable, Codable {}

extension Hero: Identifiable {}

// MARK: - Public Methods
public extension Hero {

    static var sample: Hero {
        .init(
            name: "Spiderman",
            photo: "https://i.annihil.us/u/prod/marvel/i/mg/9/30/538cd33e15ab7/standard_xlarge.jpg",
            realName: "Peter Benjamin Parker",
            height: "1.77m",
            power: "Peter can cling to most surfaces, has superhuman strength (able to lift 10 tons optimally) and is roughly 15 times more agile than a regular human.",
            abilities: "Peter is an accomplished scientist, inventor and photographer.",
            groups: "Avengers, formerly the Secret Defenders, \"New Fantastic Four\", the Outlaws"
        )
    }
    
}
