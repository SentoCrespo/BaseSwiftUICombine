import Foundation
import SwiftUI

/// Definition for a button style to be reused
/// Code sample:
/// ```
/// Button() {
///     ...
/// }
/// .buttonStyle(ButtonPrimaryStyle())
struct ButtonPrimaryStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaledFont(name: .helveticaNeue, size: .medium)
            .foregroundColor(configuration.isPressed ? Color.contrastPrimary : Color.brandPrimary)
            .padding()
            .background(configuration.isPressed ? Color.brandPrimary : Color.contrastPrimary)
            .cornerRadius(4)
    }
    
}
