import Foundation
import WidgetKit
import SwiftUI

@available(iOS 17, *)
#Preview(as: .systemSmall) {
    ProjectWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
