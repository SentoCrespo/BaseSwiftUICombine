import Foundation

extension SceneDelegate {
    
    class var isTestNoConfig: Bool {
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
    
}
