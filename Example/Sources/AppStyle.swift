import UIKit
import StyleSheet

protocol TitleFontStyle {}
protocol BodyFontStyle {}
protocol CaptionFontStyle {}
protocol MultilineLabelStyle {}
protocol RoundedCornersStyle {}
protocol LightBorderStyle {}

func appStyle(palette p: PaletteProtocol) -> StyleProtocol {
    return StyleSheet(styles: [
        /*
        Style<Any, UIView> { // DEBUG
            $0.layer.borderColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2).cgColor
            $0.layer.borderWidth = 1
        },
        */

        Style<TitleFontStyle, UILabel> { $0.font = p.font.title },

        Style<BodyFontStyle, UILabel> { $0.font = p.font.body },
        Style<BodyFontStyle, UITextField> { $0.font = p.font.body },
        Style<BodyFontStyle, UITextView> { $0.font = p.font.body },

        Style<CaptionFontStyle, UILabel> { $0.font = p.font.caption },

        Style<MultilineLabelStyle, UILabel> {
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        },

        Style<RoundedCornersStyle, UIView> {
            $0.layoutMargins = UIEdgeInsets(
                top   : p.offset.xSmall,
                left  : p.offset.small,
                bottom: p.offset.small,
                right : p.offset.xSmall
            )
            $0.layer.cornerRadius = p.offset.xSmall
            $0.clipsToBounds = true
        },

        Style<LightBorderStyle, UIView> {
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        }
    ])
}
