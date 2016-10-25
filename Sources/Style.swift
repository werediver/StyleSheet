public protocol StyleProtocol {
    func apply(to some: Any)
}

public struct Style<Marker, Target>: StyleProtocol {
    private let body: (Target) -> ()

    public func apply(to some: Any) {
        if let _ = some as? Marker, some = some as? Target {
            body(some)
        }
    }

    public init(body: (Target) -> ()) { self.body = body }
}

public struct StyleSheet: StyleProtocol {
    private let styles: [StyleProtocol]

    public func apply(to some: Any) {
        styles.forEach { $0.apply(to: some) }
    }

    public init(styles: [StyleProtocol]) { self.styles = styles }
}
