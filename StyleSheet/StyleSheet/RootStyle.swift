import UIKit

public final class RootStyle {

    public static let shared = RootStyle()

    public func autoapply(style: StyleApplicator, method: AutoapplyMethod = .swizzle) throws {
        guard self.style == nil
        else { throw Failure.alreadySetup }

        self.style = style

        try method.viewInterceptor.install(hook: apply)
    }

    private var style: StyleApplicator?

    private func apply(to some: Any) {
        style?.apply(to: some)
    }
}

public extension RootStyle {

    enum AutoapplyMethod {
        case swizzle
        case custom(ViewIntercepting.Type)

        var viewInterceptor: ViewIntercepting.Type {
            switch self {
            case .swizzle:
                return SwizzlingViewInterceptor.self
            case let .custom(viewInterceptor):
                return viewInterceptor
            }
        }
    }

    enum Failure: Error {
        case alreadySetup
    }
}
