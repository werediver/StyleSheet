final class StyleBodyMock<Target> {

    struct StyleBodyMockCaptures {

        var apply: Apply?

        final class Apply {
            let target: Target
            init(target: Target) { self.target = target }
        }
    }

    var captures = StyleBodyMockCaptures()

    func apply(to target: Target) {
        self.captures.apply = StyleBodyMockCaptures.Apply(target: target)
    }
}

