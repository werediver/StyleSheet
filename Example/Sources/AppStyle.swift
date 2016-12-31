import UIKit
import StyleSheet

protocol TitleFontStyle {}
protocol BodyFontStyle {}
protocol CaptionFontStyle {}
protocol MultilineLabelStyle {}
protocol RoundedCornersStyle {}
protocol LightBorderStyle {}

func appStyle(palette: PaletteProtocol) -> StyleProtocol {
    return StyleSheet(styles: [
        /*
        Style<Any, UIView> { // DEBUG
            $0.layer.borderColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2).cgColor
            $0.layer.borderWidth = 1
        },
        */

        Style<TitleFontStyle, UILabel> { $0.font = palette.fonts.titleFont },

        Style<BodyFontStyle, UILabel> { $0.font = palette.fonts.bodyFont },
        Style<BodyFontStyle, UITextField> { $0.font = palette.fonts.bodyFont },
        Style<BodyFontStyle, UITextView> { $0.font = palette.fonts.bodyFont },

        Style<CaptionFontStyle, UILabel> { $0.font = palette.fonts.captionFont },

        Style<MultilineLabelStyle, UILabel> {
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        },

        Style<RoundedCornersStyle, UIView> {
            $0.layoutMargins = UIEdgeInsets(
                top   : palette.offsets.xSmall,
                left  : palette.offsets.small,
                bottom: palette.offsets.small,
                right : palette.offsets.xSmall
            )
            $0.layer.cornerRadius = palette.offsets.xSmall
            $0.clipsToBounds = true
        },

        Style<LightBorderStyle, UIView> {
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        }
    ])
}
