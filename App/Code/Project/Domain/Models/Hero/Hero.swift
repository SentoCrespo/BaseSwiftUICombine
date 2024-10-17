import Foundation

public struct Hero {

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