import Foundation
import Log

class Logger: BaseLogger {
    
    static let shared: BaseLogger = {
        if BuildType.isTest {
            // Test
            return ConsoleLogger(level: .none)
        } else if BuildType.isDebug {
            // Debug
            return ConsoleLogger()
        } else {
            // Release
            return ConsoleLogger()
        }
    }()
 
}
