import UIKit

public struct RootStyle {
    public enum AutoapplyMode {
        case Swizzle
        case Appearance
    }

    enum Failure: Error {
        case NotOnMainThread
        case AlreadyInitialized
    }

    public private(set) static var style: StyleProtocol?

    public static func set(style: StyleProtocol) throws {
        try safeguard()
        self.style = style
    }

    public static func autoapply(style: StyleProtocol, mode: AutoapplyMode = .Swizzle) throws {
        try safeguard()
        self.style = style
        switch mode {
            case .Swizzle:
                swizzleInstance(UIView.self, originalSelector: #selector(UIView.willMove(toSuperview:)), swizzledSelector: #selector(UIView.__stylesheet_willMove(toSuperview:)))
            case .Appearance:
                UIView.appearance().applyRootStyle()
        }
    }

    private static func safeguard() throws {
        if !Thread.isMainThread {
            throw Failure.NotOnMainThread
        }
        if style != nil {
            throw Failure.AlreadyInitialized
        }
    }
}

extension UIView {
    private struct AssociatedKey {
        static var isStyleApplied = "isStyleApplied"
    }

    fileprivate dynamic func __stylesheet_willMove(toSuperview newSuperview: UIView?) {
        __stylesheet_willMove(toSuperview: newSuperview)
        if objc_getAssociatedObject(self, &AssociatedKey.isStyleApplied) == nil {
            objc_setAssociatedObject(self, &AssociatedKey.isStyleApplied, true, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            applyRootStyle()
        }
    }

    // This method should look like a setter to be compatible with `UIAppearance`.
    fileprivate dynamic func applyRootStyle(_: Any? = nil) {
        RootStyle.style?.apply(to: self)
    }
}

/// Based on http://nshipster.com/method-swizzling/
fileprivate func swizzleInstance<T: NSObject>(_ cls: T.Type, originalSelector: Selector, swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(cls, originalSelector)
    let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)

    let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
