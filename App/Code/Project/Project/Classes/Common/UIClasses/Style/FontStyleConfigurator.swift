import Foundation

enum Fonts: String {
    case GothamLight = "Gotham-Light"
    case Gotham = "Gotham-Medium"
    case GothamBold = "Gotham-Bold"
    
    case System = "HelveticaNeue"
    case SystemLight = "HelveticaNeue-Light"
    case SystemBold = "HelveticaNeue-Bold"
    
    func of(size: CGFloat) -> UIFont {
        let calculatedSize = UIScreen.main.scale > 2 ? size : size - 1
        return UIFont(name: self.rawValue, size: calculatedSize)!
    }
    
    func forStyle(_ style: UIFont.TextStyle) -> UIFont {
        let calculatedSize = UIFont.preferredFont(forTextStyle: style).pointSize
        return UIFont(name: self.rawValue, size: calculatedSize)!
    }
}

extension UIFont {
    static let title: UIFont = Fonts.System.of(size: 19.0)
    static let smallTitle: UIFont = Fonts.System.of(size: 14.0)
    static let subtitle: UIFont = Fonts.System.of(size: 14.0)
    static let cardSubtitle: UIFont = Fonts.System.of(size: 14.0)
    static let button: UIFont = Fonts.System.of(size: 14.0)
    static let body: UIFont = Fonts.System.of(size: 14.0)
    static let footer: UIFont = Fonts.System.of(size: 10.0)
    static let version: UIFont = Fonts.System.of(size: 12.0)
}
