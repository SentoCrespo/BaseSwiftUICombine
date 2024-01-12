import Foundation
import SwiftUI

/// Definition for a button style to be reused
/// Code sample:
/// ```
/// Button(
///    action: {
///    print("Tapped")
/// }, label: {
///    Text.body("Tap me")
/// })
/// .buttonStyle(ButtonPrimaryStyle())
/// ```
struct ButtonPrimaryStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.FontSize.button)
            .foregroundColor(configuration.isPressed ? Color.themePrimary : Color.themeSecondary)
            .padding()
            .background(configuration.isPressed ? Color.brandPrimary : Color.contrastPrimary)
            .cornerRadius(4)
    }
    
}

struct ButtonSecondaryStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.FontSize.button)
            .foregroundColor(configuration.isPressed ? Color.themeSecondary : Color.themePrimary)
            .padding()
            .background(configuration.isPressed ? Color.brandPrimary : Color.contrastSecondary)
            .cornerRadius(4)
    }
    
}

struct ButtonActionStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.FontSize.button)
            .foregroundColor(configuration.isPressed ? Color.themeSecondary : Color.themePrimary)
            .padding()
            .background(Color.clear)
    }
    
}

struct ButtonRoundStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        let size: CGFloat = 64.0
        return configuration
            .label
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.FontSize.button)
            .foregroundColor(configuration.isPressed ? Color.contrastSecondary : Color.brandPrimary)
            .padding()
            .background(configuration.isPressed ? Color.brandPrimary : Color.contrastSecondary)
            .frame(width: size, height: size, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: size))
            .overlay(RoundedRectangle(cornerRadius: size)
                .stroke(Color.darkPrimary, lineWidth: 1))
    }
    
}
