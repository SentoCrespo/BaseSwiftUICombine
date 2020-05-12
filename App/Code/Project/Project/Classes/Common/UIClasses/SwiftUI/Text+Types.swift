import Foundation
import SwiftUI

extension Text {
    
    static func largeTitle(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(name: .helveticaNeue, size: .extraLarge)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func title1(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(name: .helveticaNeue, size: .large)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func title2(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(name: .georgia, size: .large)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func title3(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(name: .helveticaNeue, size: .medium)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func headline(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(name: .georgia, size: .medium)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func subheadline(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(name: .georgia, size: .small)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func body(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(name: .helveticaNeue, size: .medium)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func callout(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(name: .helveticaNeue, size: .medium)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func footnote(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(name: .helveticaNeue, size: .small)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func caption1(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(name: .helveticaNeue, size: .small)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func caption2(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(name: .helveticaNeue, size: .extraSmall)
            .foregroundColor(Color.themePrimary)
        return result
    }

}

