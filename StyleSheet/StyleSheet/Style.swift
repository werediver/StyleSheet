public protocol StyleApplicator {

    func apply(to some: Any)
}

public struct Style<Marker, Target>: StyleApplicator {

    public typealias Body = (Target) -> Void

    private let body: Body

    public init(_ body: @escaping Body) {
        self.body = body
    }

    public func apply(to some: Any) {
        if let some = some as? Target, some is Marker {
            body(some)
        }
    }
}

public struct StyleSheet: StyleApplicator {

    private let styles: [StyleApplicator]

    public init(styles: [StyleApplicator]) {
        self.styles = styles
    }

    public func apply(to some: Any) {
        styles.forEach { style in
            style.apply(to: some)
        }
    }
}
