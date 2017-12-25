import class Foundation.NSObject
import ObjectiveC

class BaseSwizzleTarget: NSObject {

    @objc dynamic
    func baseTest() {}
}

final class SwizzleTarget: BaseSwizzleTarget {

    struct Captures {

        var test: Test?
        var swizzleTest: SwizzleTest?

        struct Test {}
        struct SwizzleTest {}
    }

    var captures = Captures()

    @objc dynamic
    func test() {
        captures.test = Captures.Test()
    }

    static func backup() {
        guard
            referenceImplementations == nil
        else { return }

        let cls = SwizzleTarget.self

        guard
            let referenceTestMethod = class_getInstanceMethod(cls, #selector(test)),
            let referenceSwizzleTestMethod = class_getInstanceMethod(cls, #selector(__swizzle_test))
        else { fatalError() }

        referenceImplementations = ReferenceImplementations(
            test: method_getImplementation(referenceTestMethod),
            swizzleTest: method_getImplementation(referenceSwizzleTestMethod)
        )
    }

    static func restore() {
        guard
            let referenceMethods = referenceImplementations
        else { fatalError() }

        let cls = SwizzleTarget.self

        guard
            let testMethod = class_getInstanceMethod(cls, #selector(test)),
            let swizzleTestMethod = class_getInstanceMethod(cls, #selector(__swizzle_test))
        else { fatalError() }

        method_setImplementation(testMethod, referenceMethods.test)
        method_setImplementation(swizzleTestMethod, referenceMethods.swizzleTest)
    }

    private static var referenceImplementations: ReferenceImplementations?

    private struct ReferenceImplementations {
        let test: IMP
        let swizzleTest: IMP
    }
}

extension SwizzleTarget {

    @objc dynamic
    func __swizzle_test() {
        captures.swizzleTest = Captures.SwizzleTest()
    }

    @objc dynamic
    func __swizzle_other(_: String) {}
}
