import Foundation
import SwiftUI

extension Text {
    
    static func headline(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(name: .helveticaNeue, size: .medium)
        return result
    }

    // TODO: Complete with all styles
//    .largeTitle
//    .title1
//    .title2
//    .title3
//    .headline
//    .subheadline
//    .body
//    .callout
//    .footnote
//    .caption1
//    .caption2
}

