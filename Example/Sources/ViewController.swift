import UIKit

final class ViewController: UIViewController {}

final class TitleLabel: UILabel, TitleFontStyle {}
final class BodyLabel: UILabel, BodyFontStyle, MultilineLabelStyle {}
final class CaptionLabel: UILabel, CaptionFontStyle, MultilineLabelStyle {}

// Try commenting out these lines.
extension TitledSwitchView: RoundedCornersStyle, LightBorderStyle {}
extension TitledSwitchView.TitleLabel: BodyFontStyle {}
extension TitledSwitchView.DetailLabel: CaptionFontStyle, MultilineLabelStyle {}
