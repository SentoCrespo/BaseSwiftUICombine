import Foundation
import WidgetKit
import SwiftUI

struct ImageWidgetLive {
    static let leading = Image(systemName: "cup.and.saucer")
    static let trailing = Image(systemName: "cup.and.saucer.fill")
}

@available(iOS 16.1, *)
struct LiveWidgetUIView: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(
            for: LiveWidgetActivityAttributes.self,
            content: { context in
                // Lock screen/banner UI goes here
                LiveActivityView(state: context.state)
            },
            dynamicIsland: { context in
                DynamicIsland {
                    DynamicIslandExpandedRegion(.leading) {
                        ImageWidgetLive.leading
                    }
                    DynamicIslandExpandedRegion(.trailing) {
                        ImageWidgetLive.trailing
                    }
                    DynamicIslandExpandedRegion(.bottom) {
                        VStack {
                            ImageWidgetLive.leading
                            Text("\(context.state.status.description)")
                        }
                    }
                } compactLeading: {
                    ImageWidgetLive.leading
                } compactTrailing: {
                    ImageWidgetLive.trailing
                } minimal: {
                    ImageWidgetLive.leading
                }
            })
        .configurationDisplayName("Live Activity")
        .description("This is a live activity example.")
    }
    
}

struct LiveActivityView: View {
    let state: LiveWidgetActivityAttributes.ContentState
    
    var body: some View {
        VStack {
            HStack {
                ImageWidgetLive.leading
                ProgressView(value: state.status.rawValue, total: 3)
                    .tint(.black)
                    .background(Color.brown)
                ImageWidgetLive.trailing
            }
            .padding(16)
            
            Text("\(state.status.description)")
                .font(.system(size: 18, weight: .semibold))
                .padding(.bottom)
            Spacer()
        }
        .background(Color.brown.opacity(0.6))
    }
}
