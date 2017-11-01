#if os(iOS) || os(tvOS)
import UIKit
private typealias View = UIView
private let ViewDidMoveToWindowSelector = #selector(View.didMoveToWindow)
#elseif os(OSX)
import Cocoa
private typealias View = NSView
private let ViewDidMoveToWindowSelector = #selector(View.viewDidMoveToWindow)
#endif

public struct RootStyle {
    private static var isStyleAppliedKey = "isStyleApplied"

    public enum AutoapplyMethod {
        case swizzle
        @available(OSX, unavailable)
        case appearance
    }

    public enum Failure: Error {
        case notOnMainThread
        case alreadyInitialized
        case autoapplyFailed
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
    public static func autoapply(style: StyleProtocol, mode: AutoapplyMethod = .swizzle) throws {
        try safeguard()
        self.style = style
        switch mode {
        case .swizzle:
            do {
                try swizzleInstance(View.self, originalSelector: ViewDidMoveToWindowSelector, swizzledSelector: #selector(View.__stylesheet_didMoveToWindow))
            } catch {
                throw Failure.autoapplyFailed
            }
        case .appearance:
            #if os(iOS) || os(tvOS)
            View.appearance().__stylesheet_applyRootStyle()
            #endif
        }
    }

    private static func safeguard() throws {
        if !Thread.isMainThread {
            throw Failure.notOnMainThread
        }
        if style != nil {
            throw Failure.alreadyInitialized
        }
    }
}

fileprivate extension View {
    @objc dynamic
    func __stylesheet_didMoveToWindow() {
        __stylesheet_didMoveToWindow()
        RootStyle.apply(to: self)
    }

    // This method should look like a setter to be compatible with `UIAppearance`.
    @objc dynamic
    func __stylesheet_applyRootStyle(_: Any? = nil) {
        RootStyle.apply(to: self)
    }
}

/// Based on http://nshipster.com/method-swizzling/
private func swizzleInstance<T: NSObject>(_ cls: T.Type, originalSelector: Selector, swizzledSelector: Selector) throws {
    guard
        let originalMethod = class_getInstanceMethod(cls, originalSelector),
        let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
    else { throw SwizzleError.selectorNotFound }

    let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

private enum SwizzleError: Error {
    case selectorNotFound
}
