import Foundation
import ActivityKit
import WidgetKit
import SwiftUI

@available(iOS 17.0, *)
struct LiveWidgetUIView_DynamicIslanc_Previews: PreviewProvider {
    
    static var previews: some View {
        self.createPreview()
    }

}

@available(iOS 17.0, *)
extension LiveWidgetUIView_DynamicIslanc_Previews {
    
    static func createPreview() -> some View {
        
        let previewContent = LiveWidgetActivityAttributes(orderNumber: 11)
        
        let previewState = LiveWidgetActivityAttributes.ContentState(
            date: .now,
            status: .making
        )
        
        let dynamicIslandState = ActivityPreviewViewKind
            .DynamicIslandPreviewViewState
            .expanded
        // .compact
        //.minimal
        
        return previewContent
            .previewContext(previewState, viewKind: .dynamicIsland(dynamicIslandState))
            .previewDisplayName("Preview")
    }
    
}
 
