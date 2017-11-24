import ObjectiveC

public final class RootStyle {

    public enum Failure: Error {
        case alreadyInitialized
    }

    private var style: StyleApplicator?

    public init() {}

    public func set(style: StyleApplicator) throws {
        guard self.style == nil
        else { throw Failure.alreadyInitialized }

        self.style = style
    }

    public func apply(to some: Any) {
        style?.apply(to: some)
    }

//    private func oncePerObject(_ some: AnyObject, _ body: () -> Void) {
//        let key = UnsafeRawPointer((#function as StaticString).utf8Start)
//        if objc_getAssociatedObject(some, key) == nil {
//            objc_setAssociatedObject(some, key, true, .OBJC_ASSOCIATION_RETAIN)
//            body()
//        }
//    }
}
