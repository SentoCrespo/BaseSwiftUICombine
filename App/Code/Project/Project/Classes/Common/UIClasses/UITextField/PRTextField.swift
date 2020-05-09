import Foundation
import UIKit

class PRTextField: UITextField {
    var rightImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        // Blinking cursor
//        //        let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
//        //        self.tintColor = overcastBlueColor
//        self.textColor = .fontPrimaryDark1
//
//        self.titleColor = .fontPrimaryDark1
//        self.selectedTitleColor = .fontPrimaryDark1
//
//        self.lineColor = .fontPrimaryDark1
//        self.selectedLineColor = .fontPrimaryDark1
//
//        self.lineHeight = 1.0 // In points
//        self.selectedLineHeight = 2.0
//
//        self.autocorrectionType = .no
//
//        self.titleFormatter = { text in
//            return text
//        }
//
//        self.font = UIFont.body
//
//        self.keyboardAppearance = .light
    }
    
//    func setImage(_ image: UIImage?) {
//        rightImageView?.removeFromSuperview()
//
//        guard let image = image else {
//            self.rightViewMode = .never
//            return
//        }
//
//        let imageView = UIImageView()
//        imageView.backgroundColor = UIColor.clear
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = image
//        imageView.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
//        rightImageView = imageView
//
//        self.addSubview(imageView)
//        self.rightViewMode = .always
//        self.rightView = imageView
//    }
    
    // Placeholder fix:
    // Remove "|| isHighlighted" from fileprivate func updateTitleColor()
    
    //    // Placeholder
    //    override func textRect(forBounds bounds: CGRect) -> CGRect {
    //        return bounds.insetBy(dx: 10, dy: 0)
    //    }
    //
    //    // Text position
    //    override func editingRect(forBounds bounds: CGRect) -> CGRect {
    //        return bounds.insetBy(dx: 10, dy: 0)
    //    }
}
