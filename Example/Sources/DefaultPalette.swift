import UIKit

protocol PaletteProtocol {
    var fonts: FontPaletteProtocol { get }
}

protocol FontPaletteProtocol {
    var titleFont: UIFont { get }
    var bodyFont: UIFont { get }
    var captionFont: UIFont { get }
}

struct DefaultPalette: PaletteProtocol {
    struct DefaultFontPalette: FontPaletteProtocol {
        let titleFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title3)
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        let captionFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
    }

    let fonts: FontPaletteProtocol = DefaultFontPalette()
}
