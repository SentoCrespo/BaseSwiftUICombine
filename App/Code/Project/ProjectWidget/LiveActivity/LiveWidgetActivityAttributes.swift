import Foundation
import ActivityKit
import WidgetKit

struct LiveWidgetActivityAttributes: ActivityAttributes {
    
    // Static properties
    let orderNumber: Int
    
    // Dynamic properties
    struct ContentState: Codable, Hashable {
        let date: Date
        let status: OrderStatus
    }
    
}

enum OrderStatus: Float {
    case inQueue
    case aboutToTake
    case making
    case ready
}

extension OrderStatus: Codable, Hashable {}

extension OrderStatus {
    
    var description: String {
        switch self {
        case .inQueue:
            return "Your order is in the queue"
        case .aboutToTake:
            return "We're about to take your order"
        case .making:
            return "We're preparing your order"
        case .ready:
            return "Your order is ready to pick up!"
        }
    }
}
