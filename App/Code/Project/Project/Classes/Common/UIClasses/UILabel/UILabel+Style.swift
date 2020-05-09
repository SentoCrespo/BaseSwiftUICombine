import UIKit

extension UILabel {
    func styleTitle() {
        self.font = UIFont.title
    }
    
    func styleSmallTitle() {
        self.font = UIFont.smallTitle
    }
    
    func styleSubtitle() {
        self.font = UIFont.subtitle
    }
    
    func styleCardSubtitle() {
        self.font = UIFont.cardSubtitle
    }
    
    func styleBody() {
        self.font = UIFont.body
    }
    
    func styleFooter() {
        self.font = UIFont.footer
        self.textColor = .bgPrimaryDisabled
    }
}
