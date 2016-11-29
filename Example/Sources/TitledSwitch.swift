import UIKit

@IBDesignable
final class TitledSwitchView: UIView {
    final class TitleLabel: UILabel {}
    final class DetailLabel: UILabel {}
    final class SwitchView: UISwitch {
        override var alignmentRectInsets: UIEdgeInsets {
            // The original `alignmentRectInsets` could be wrong.
            return .zero
        }
    }

    private struct Offset {
        static let xSmall: CGFloat = 4
        static let small: CGFloat = 8
    }

    @IBInspectable var titleText: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }

    @IBInspectable var detailText: String? {
        get { return detailLabel.text }
        set { detailLabel.text = newValue }
    }

    @IBInspectable var switchValue: Bool {
        get { return switchView.isOn }
        set { switchView.isOn = newValue }
    }

    private(set) lazy var titleLabel: UILabel = TitleLabel().ignoreAutoresizingMask()
    private(set) lazy var detailLabel: UILabel = DetailLabel().ignoreAutoresizingMask()
    private(set) lazy var switchView: UISwitch = SwitchView().ignoreAutoresizingMask()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }

    private func commonInit() {
        self.layoutMargins = .zero

        [titleLabel, detailLabel, switchView]
            .forEach(self.addSubview)

        titleLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)
        titleLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)

        titleLabel.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor)
            .activate()
        titleLabel.rightAnchor.constraint(lessThanOrEqualTo: switchView.leftAnchor, constant: -Offset.small)
            .activate()

        titleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.layoutMarginsGuide.topAnchor)
            .activate()
        titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor)
            .activate()
            .priority = UILayoutPriorityDefaultHigh
        titleLabel.centerYAnchor.constraint(equalTo: switchView.centerYAnchor)
            .activate()

        switchView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor)
            .activate()
        switchView.topAnchor.constraint(greaterThanOrEqualTo: self.layoutMarginsGuide.topAnchor)
            .activate()
        switchView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor)
            .activate()
            .priority = UILayoutPriorityDefaultHigh

        detailLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)

        detailLabel.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor)
            .activate()
        detailLabel.rightAnchor.constraint(lessThanOrEqualTo: switchView.leftAnchor, constant: -Offset.small)
            .activate()
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Offset.xSmall)
            .activate()
        detailLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.layoutMarginsGuide.bottomAnchor)
            .activate()
    }

    override var intrinsicContentSize: CGSize {
        let titleLabelSize = titleLabel.intrinsicContentSize
        let switchViewSize = switchView.intrinsicContentSize
        let detailLabelSize = detailLabel.intrinsicContentSize
        let size = CGSize(
        	width: max(titleLabelSize.width + Offset.small + switchViewSize.width, detailLabelSize.width) + self.layoutMargins.left + self.layoutMargins.right,
            height: (titleLabelSize.height > switchViewSize.height ? titleLabelSize.height : (switchViewSize.height + titleLabelSize.height) / 2) + detailLabelSize.height + Offset.xSmall + self.layoutMargins.top + self.layoutMargins.bottom
        )
        return size
    }
}
