import Foundation

public struct Empty: Codable {
    // MARK: - Properties
    
    // MARK: - Life Cycle
    public init() {}
    
}

// MARK: - Hashable
extension Empty: Hashable {
    
    public func hash(into hasher: inout Hasher) {}
    
}

// MARK: - Equatable
extension Empty: Equatable {
    
    public static func == (_ left: Empty, _ right: Empty) -> Bool {
        return true
    }
    
}
