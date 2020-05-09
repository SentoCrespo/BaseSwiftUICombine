import Foundation
import UIKit

class ButtonAction: UIButtonBase {
    override var defaultModel: ButtonAppearanceModel {
        return ButtonAppearanceModel(
            height: 44.0,
            cornerRadius: 22.0,
            font: .button,
            textColorNormal: .fontPrimaryLight,
            textColorSelected: .lightGray,
            textColorDisabled: .fontPrimaryLight,
            backgroundColorNormal: .bgPrimaryDark,
            backgroundColorDisabled: .bgPrimaryDisabled,
            backgroundColorHighlighted: .bgPrimaryDark,
            insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
            titleTransformation: { return $0?.uppercased() }
        )
    }
}
