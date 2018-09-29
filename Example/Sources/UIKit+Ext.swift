import UIKit

extension UIView {

    @discardableResult
    func ignoreAutoresizingMask() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

extension NSLayoutConstraint {

    @discardableResult
    func activate() -> Self {
        self.isActive = true
        return self
    }
}
