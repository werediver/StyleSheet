import class UIKit.UIView

final class SwizzlingViewInterceptor: ViewIntercepting {

    enum Failure: Error {
        case alreadyInstalled
    }

    private(set) static var hook: Hook?

    static func install(hook: @escaping Hook) throws {
        guard self.hook == nil
        else { throw Failure.alreadyInstalled }

        self.hook = hook

        try swizzle(instanceOf: UIView.self, selectors: #selector(UIView.didMoveToWindow), #selector(UIView.__stylesheet_didMoveToWindow))
    }
}

private extension UIView {

    @objc
    func __stylesheet_didMoveToWindow() {
        __stylesheet_didMoveToWindow()
        SwizzlingViewInterceptor.hook?(self)
    }
}
