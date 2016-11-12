import UIKit
import StyleSheet

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
