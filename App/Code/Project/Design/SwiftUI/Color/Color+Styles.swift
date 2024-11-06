import Foundation
import SwiftUI

/// Dynamic color sets (Light & Dark Mode)
/// Reference: https://airtable.com/shrHQdv9vQGz7UMQj/tblH3GqNwWSvZmrGX/viwKQnM5JrVAWzHIr
public extension Color {
    
    // Brand
    static let brandPrimary: Color = Color(R.color.brandPrimary.name)
    
    // Contrast
    static let contrastPrimary: Color = Color(R.color.contrastPrimary.name)
    static let contrastSecondary: Color = Color(R.color.contrastSecondary.name)

    // Theme
    static let themePrimary: Color = Color(R.color.themePrimary.name)
    static let themeSecondary: Color = Color(R.color.themeSecondary.name)
    
}

/// Static color sets
public extension Color {
    
    static let darkPrimary: Color = Color(R.color.darkPrimary.name)
    static let gray: Color = Color(R.color.gray.name)
    static let lightPrimary: Color = Color(R.color.lightPrimary.name)
    
}
