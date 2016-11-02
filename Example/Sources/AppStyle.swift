import UIKit
import StyleSheet

protocol FontPaletteProtocol {
    var titleFont: UIFont { get }
    var bodyFont: UIFont { get }
    var captionFont: UIFont { get }
}

protocol PaletteProtocol {
    var fonts: FontPaletteProtocol { get }
}

struct DefaultPalette: PaletteProtocol {
    struct DefaultFontPalette: FontPaletteProtocol {
        let titleFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title3)
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        let captionFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
    }

    let fonts: FontPaletteProtocol = DefaultFontPalette()
}

protocol TitleFontStyle {}
protocol BodyFontStyle {}
protocol CaptionFontStyle {}
protocol MultilineLabelStyle {}

func appStyle(palette: PaletteProtocol) -> StyleProtocol {
    return StyleSheet(styles: [
        Style<TitleFontStyle, UILabel> { $0.font = palette.fonts.titleFont },
        Style<BodyFontStyle, UILabel> { $0.font = palette.fonts.bodyFont },
        Style<CaptionFontStyle, UILabel> { $0.font = palette.fonts.captionFont },
        Style<MultilineLabelStyle, UILabel> { $0.numberOfLines = 0 }
    ])
}
