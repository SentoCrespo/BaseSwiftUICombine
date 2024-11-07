import Foundation
import ActivityKit
import WidgetKit
import SwiftUI

@available(iOS 17.0, *)
struct LiveWidgetUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        self.createPreview()
    }
    
}

@available(iOS 17.0, *)
extension LiveWidgetUIView_Previews {
    
    static func createPreview() -> some View {

        let previewState = LiveWidgetActivityAttributes.ContentState(
            date: .now,
            status: .making
        )
        
        let result = LiveActivityView(
            state: previewState
        )
        .containerBackground(
            .clear,
            for: .widget
        )
        .previewContext(WidgetPreviewContext(family: .systemMedium))
        
        return result

    }
    
}
