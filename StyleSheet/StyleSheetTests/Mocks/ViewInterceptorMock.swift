import protocol StyleSheet.ViewIntercepting

final class ViewInterceptorMock: ViewIntercepting {

    struct Captures {
        var install: Install?

        struct Install {
            let hook: Hook
        }
    }

    struct Stubs {
        var installError: Error?
    }

    static var captures = Captures()
    static var stubs = Stubs()

    static func install(hook: @escaping Hook) throws {
        captures.install = Captures.Install(hook: hook)
        if let error = stubs.installError {
            throw error
        }
    }
}
