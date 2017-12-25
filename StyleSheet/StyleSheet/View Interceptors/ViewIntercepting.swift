import class UIKit.UIView

public protocol ViewIntercepting {

    typealias Hook = (UIView) -> Void

    static func install(hook: @escaping Hook) throws
}
