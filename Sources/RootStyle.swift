import UIKit

public struct RootStyleHolder {
    public static var rootStyle: StyleProtocol?

    public static func autoapply() {
        _ = RootStyleHolder.__once
    }

    private static let __once: () = {
        swizzleInstance(UIView.self, originalSelector: #selector(UIView.init(frame:)), swizzledSelector: #selector(UIView.__stylesheet_init(frame:)))
        swizzleInstance(UIView.self, originalSelector: #selector(UIView.awakeFromNib), swizzledSelector: #selector(UIView.__stylesheet_awakeFromNib))
    }()
}

extension UIView {
    dynamic func __stylesheet_init(frame: CGRect) -> Self {
        let result = __stylesheet_init(frame: frame)
        applyRootStyle()
        return result
    }

    dynamic func __stylesheet_awakeFromNib() {
        __stylesheet_awakeFromNib()
        applyRootStyle()
    }

    private func applyRootStyle() {
        RootStyleHolder.rootStyle?.apply(to: self)
    }
}

/// Based on http://nshipster.com/method-swizzling/
func swizzleInstance<T: NSObject>(_ cls: T.Type, originalSelector: Selector, swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(cls, originalSelector)
    let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)

    let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
