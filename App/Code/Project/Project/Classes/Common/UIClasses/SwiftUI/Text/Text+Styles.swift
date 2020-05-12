import Foundation
import SwiftUI

extension Text {
    
    static func largeTitle(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.fontSize.largeTitle)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func title1(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.fontSize.title1)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func title2(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.fontSize.title2)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func title3(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.fontSize.title3)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func headline(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.fontSize.headline)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func body(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.fontSize.body)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func subheadline(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: .helveticaNeueSemiBold,
                size: Typography.fontSize.subhead)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func callout(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.fontSize.callout)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func footnote(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.fontSize.callout)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func caption1(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.fontSize.caption1)
            .foregroundColor(Color.themePrimary)
        return result
    }
    
    static func caption2(_ text: String) -> some View {
        let result = Text(text)
            .scaledFont(
                name: .helveticaNeue,
                size: Typography.fontSize.caption2)
            .foregroundColor(Color.themePrimary)
        return result
    }

}

