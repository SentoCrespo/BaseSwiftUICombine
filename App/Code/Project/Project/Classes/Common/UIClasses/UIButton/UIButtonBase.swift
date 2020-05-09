import UIKit

class UIButtonBase: UIButton {
    var heightC: NSLayoutConstraint?
    var appearanceModel: ButtonAppearanceModel?
    
    var defaultModel: ButtonAppearanceModel {
        return ButtonAppearanceModel.default
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }
    
    func commonInit() {
        self.appearanceModel = defaultModel
        self.updateUI()
    }
    
    func updateAppearanceModel(_ appearanceModel: ButtonAppearanceModel) {
        self.appearanceModel = appearanceModel
        self.updateUI()
        self.setTitle(self.title(for: .normal), for: .normal) // For text transformation
        self.setNeedsLayout()
    }
    
    func updateUI() {
        let appearance = self.appearanceModel ?? defaultModel
        
        let noPadding: CGFloat = 0.0
        let smallPadding: CGFloat = 5.0
        let mediumPadding: CGFloat = 12.0
        
        if self.currentImage != nil {
            if self.titleLabel?.text != nil {
                self.contentEdgeInsets = UIEdgeInsets(top: smallPadding, left: noPadding, bottom: smallPadding, right: mediumPadding)
            } else {
                self.contentEdgeInsets = UIEdgeInsets(top: smallPadding, left: smallPadding, bottom: smallPadding, right: smallPadding)
            }
        } else {
            self.contentEdgeInsets = UIEdgeInsets(top: mediumPadding, left: mediumPadding, bottom: mediumPadding, right: mediumPadding)
        }
        
        // Override isnets if they are defined
        if let insets = appearance.insets {
            self.contentEdgeInsets = insets
        }
        
        // Define height
        // TODO: With Autolayout?
//        if let heightC = self.heightC {
//            self.removeConstraint(heightC)
//        }
//
//        let priority = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)
//        NSLayoutConstraint.autoSetPriority(priority) {
//            self.heightC = appearance.height.map {
//                self.autoSetDimension(.height, toSize: $0)
//            }
//        }
        
        // Size
        if let font = appearance.font {
            self.titleLabel?.font = font
        }
        self.titleLabel?.minimumScaleFactor = 0.7
        self.adjustsImageWhenHighlighted = false
        
        // Background
        if let backgroundColorNormal = appearance.backgroundColorNormal {
            self.setBackgroundColor(backgroundColorNormal, for: .normal)
        }
        if let backgroundColorHighlighted = appearance.backgroundColorHighlighted {
            self.setBackgroundColor(backgroundColorHighlighted, for: .highlighted)
        }
        if let backgroundColorDisabled = appearance.backgroundColorDisabled {
            self.setBackgroundColor(backgroundColorDisabled, for: .disabled)
        }
        
        // Text
        self.setTitleColor(appearance.textColorNormal, for: .normal)
        self.setTitleColor(appearance.textColorDisabled, for: .disabled)
        self.setTitleColor(appearance.textColorSelected, for: .highlighted)
        self.setTitleColor(appearance.textColorSelected, for: .selected)
        
        // Image
        self.imageView?.contentMode = .scaleAspectFit
        self.tintColor = UIColor.white
    }
    
    override var isHighlighted: Bool {
        didSet {
            let appearance = self.appearanceModel ?? self.defaultModel
            backgroundColor = isHighlighted ? appearance.backgroundColorHighlighted : appearance.backgroundColorNormal
        }
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        let appearance = self.appearanceModel ?? self.defaultModel
        guard let titleTransformation = appearance.titleTransformation else {
            super.setTitle(title, for: state)
            return
        }
        let newTitle = titleTransformation(title)
        super.setTitle(newTitle, for: state)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let appearance = self.appearanceModel ?? self.defaultModel
        self.layer.cornerRadius = appearance.cornerRadius ?? 0
        //        self.layer.borderWidth = appearance.borderWidth ?? 0
        //        self.layer.borderColor = appearance.borderColor?.cgColor ?? UIColor.clear.cgColor
        
        self.clipsToBounds = true
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
}
