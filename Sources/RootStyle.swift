import UIKit

public struct RootStyle {
    private static var isStyleAppliedKey = "isStyleApplied"

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

    /// Apply the root style to `some` object once. Subsequent calls do nothing.
    public static func apply(to some: AnyObject) {
        if objc_getAssociatedObject(some, &isStyleAppliedKey) == nil {
            objc_setAssociatedObject(some, &isStyleAppliedKey, true, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            style?.apply(to: some)
        }
    }

    // Apply the root style to every `UIView` automatically once.
    public static func autoapply(style: StyleProtocol, mode: AutoapplyMode = .Swizzle) throws {
        try safeguard()
        self.style = style
        switch mode {
            case .Swizzle:
                swizzleInstance(UIView.self, originalSelector: #selector(UIView.didMoveToWindow), swizzledSelector: #selector(UIView.__stylesheet_didMoveToWindow))
            case .Appearance:
                UIView.appearance().__stylesheet_applyRootStyle()
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
    fileprivate dynamic func __stylesheet_didMoveToWindow() {
        __stylesheet_didMoveToWindow()
        RootStyle.apply(to: self)
    }

    // This method should look like a setter to be compatible with `UIAppearance`.
    fileprivate dynamic func __stylesheet_applyRootStyle(_: Any? = nil) {
        RootStyle.apply(to: self)
    }
}

/// Based on http://nshipster.com/method-swizzling/
private func swizzleInstance<T: NSObject>(_ cls: T.Type, originalSelector: Selector, swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(cls, originalSelector)
    let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)

    let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
