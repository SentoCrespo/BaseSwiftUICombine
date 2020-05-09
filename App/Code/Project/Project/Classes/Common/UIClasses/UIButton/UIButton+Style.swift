import UIKit

extension UIButton {
    func styleTitle() {
        self.titleLabel?.font = UIFont.title
    }
    
    func styleSmallTitle() {
        self.titleLabel?.font = UIFont.smallTitle
    }
    
    func styleSubtitle() {
        self.titleLabel?.font = UIFont.subtitle
    }
    
    func styleCardSubtitle() {
        self.titleLabel?.font = UIFont.cardSubtitle
    }
    
    func styleBody() {
        self.titleLabel?.font = UIFont.body
    }
}
