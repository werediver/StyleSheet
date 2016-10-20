import UIKit

struct RootStyleHolder {
    static var rootStyle: StyleProtocol?
}

extension UIView {
    override public class func initialize() {
        struct Static { static var token = dispatch_once_t() }
        dispatch_once(&Static.token) {
            swizzleInstance(self, originalSelector: #selector(UIView.init(frame:)), swizzledSelector: #selector(UIView.__init(frame:)))
            swizzleInstance(self, originalSelector: #selector(UIView.awakeFromNib), swizzledSelector: #selector(UIView.__awakeFromNib))
        }
    }

    private dynamic func __init(frame frame: CGRect) -> Self {
        let result = __init(frame: frame)
        applyRootStyle()
        return result
    }

    private dynamic func __awakeFromNib() {
        __awakeFromNib()
        applyRootStyle()
    }

    private func applyRootStyle() {
        RootStyleHolder.rootStyle?.apply(to: self)
    }
}

/// Based on http://nshipster.com/method-swizzling/
private func swizzleInstance<T: NSObject>(_: T.Type, originalSelector: Selector, swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(T.self, originalSelector)
    let swizzledMethod = class_getInstanceMethod(T.self, swizzledSelector)

    let didAddMethod = class_addMethod(T.self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

    if (didAddMethod) {
        class_replaceMethod(T.self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
