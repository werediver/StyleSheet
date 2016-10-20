protocol StyleProtocol {
    func apply(to some: Any)
}

struct Style<Marker, Target>: StyleProtocol {
    private let body: (Target) -> ()
    func apply(to some: Any) {
        if let _ = some as? Marker, some = some as? Target {
            body(some)
        }
    }
    init(body: (Target) -> ()) { self.body = body }
}

struct StyleSheet: StyleProtocol {
    private let styles: [StyleProtocol]
    func apply(to some: Any) {
        styles.forEach { $0.apply(to: some) }
    }
    init(styles: [StyleProtocol]) { self.styles = styles }
}
