import Foundation
import WidgetKit
import SwiftUI

@main
struct CoffeeShopWidgetBundle: WidgetBundle {
    var body: some Widget {
        CardWidgetUIView()
        if #available(iOS 16.1, *) {
            LiveWidgetUIView()
        }
    }
}
