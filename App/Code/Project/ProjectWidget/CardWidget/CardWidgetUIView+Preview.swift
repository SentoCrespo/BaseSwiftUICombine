import Foundation
import WidgetKit
import SwiftUI

@available(iOS 17, *)
#Preview(as: .systemSmall) {
    CardWidgetUIView()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
