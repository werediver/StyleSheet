import protocol StyleSheet.StyleApplicator

final class StyleMock: StyleApplicator {

    struct Captures {

        var apply: Apply?

        struct Apply {
            let some: Any
        }
    }

    var captures = Captures()

    func apply(to some: Any) {
        self.captures.apply = Captures.Apply(some: some)
    }
}
