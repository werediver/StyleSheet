import UIKit

protocol PaletteProtocol {
    var font: FontPaletteProtocol { get }
    var offset: OffsetPaletteProtocol { get }
}

protocol OffsetPaletteProtocol {
    var xSmall: CGFloat { get }
    var small: CGFloat { get }
}

protocol FontPaletteProtocol {
    var title: UIFont { get }
    var body: UIFont { get }
    var caption: UIFont { get }
}

struct DefaultPalette: PaletteProtocol {
    let font: FontPaletteProtocol = FontPalette()
    let offset: OffsetPaletteProtocol = OffsetPalette()

    struct OffsetPalette: OffsetPaletteProtocol {
        let xSmall: CGFloat = 4
        let small: CGFloat = 8
    }

    struct FontPalette: FontPaletteProtocol {
        let title = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title3)
        let body = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        let caption = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
    }
}
