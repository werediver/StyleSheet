import protocol StyleSheet.StyleApplicator

class Target {}
final class MarkedTarget: Target, Marker {}
protocol Marker {}

final class StyleBodyMock<Target> {

    var target: Target?

    func apply(to target: Target) {
        self.target = target
    }
}

final class StyleMock: StyleApplicator {

    var some: Any?

    func apply(to some: Any) {
        self.some = some
    }
}
