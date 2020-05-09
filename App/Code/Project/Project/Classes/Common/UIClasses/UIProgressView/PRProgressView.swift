import Foundation
import UIKit

class PRProgressView: UIProgressView {
    // MARK: Properties
    
    fileprivate let kProgressViewHeight: CGFloat = 20.0
    
    // MARK: LIfe Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tintColor = UIColor.clear
        self.progressTintColor = .bgPrimaryDark
        self.trackTintColor = UIColor.clear
        self.isUserInteractionEnabled = false
        
        self.layer.borderColor = UIColor.bgPrimaryDisabled.cgColor
        self.layer.borderWidth = 0.5
        // TODO: Implement with AutoLayout?
//        self.autoSetDimension(.height, toSize: 22.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.kProgressViewHeight / 2.0
        self.clipsToBounds = true
        
        subviews.forEach { subview in
            subview.layer.masksToBounds = true
            subview.layer.cornerRadius = self.kProgressViewHeight / 2.0
        }
    }
}
