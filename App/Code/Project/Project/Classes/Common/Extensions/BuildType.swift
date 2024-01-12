import Foundation

struct BuildType {
    
    static var isTest: Bool {
        if ProcessInfo.processInfo.processName == "xctest" {
            return true
        }
        if let environment = ProcessInfo.processInfo.environment["XCInjectBundle"] {
            if environment.isEmpty == false {
                return true
            }
        }
        return NSClassFromString("XCTest") != nil
    }
    
    static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
}
