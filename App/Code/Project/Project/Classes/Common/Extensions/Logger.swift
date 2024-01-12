import Foundation
import OSLog

/// String interpolation:
/// - Sensible information: \(variable, privacy: .private)
/// - Alignement: \(variable, align: .left(columns: 10))
/// - Number formatting \(variable, format: .fixed(precision: 2))
extension Logger {
    
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs app information
    static let app = Logger(subsystem: subsystem, category: "app")
    
    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
    
    /// All logs related to tracking and analytics.
    static let analytics = Logger(subsystem: subsystem, category: "analytics")
    
}
