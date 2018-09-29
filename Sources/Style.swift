public protocol StyleApplicator {

    func apply(to some: Any)
}

public struct Style<Marker, Target>: StyleApplicator {

    private let body: (Target) -> ()

    public init(body: @escaping (Target) -> ()) {
        self.body = body
    }

    public func apply(to some: Any) {
        if some is Marker, let some = some as? Target {
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
        styles.forEach { $0.apply(to: some) }
    }
}
