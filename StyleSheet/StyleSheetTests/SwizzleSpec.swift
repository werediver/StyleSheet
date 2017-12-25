import Quick
import Nimble
@testable import StyleSheet

final class SwizzleSpec: QuickSpec {

    func testSpec() { spec() }

    override func spec() {
        describe("swizzle") {

            beforeEach {
                SwizzleTarget.backup()
            }

            afterEach {
                SwizzleTarget.restore()
            }

            whenCalled(with: "existing compatible selectors",
                selectors: #selector(SwizzleTarget.test), #selector(SwizzleTarget.__swizzle_test))
            { getSUTError in

                it("succeeds") {
                    expect(getSUTError()).to(beNil())
                }

                describe("swizzled target") {
                    var target: SwizzleTarget!

                    beforeEach {
                        target = SwizzleTarget()
                    }

                    afterEach {
                        target = nil
                    }

                    context("tested") {

                        beforeEach {
                            target.test()
                        }

                        it("behaves swizzled") {
                            expect(target.captures.test).to(beNil())
                            expect(target.captures.swizzleTest).toNot(beNil())
                        }

                        it("behaves swizzled no matter what") {
                            expect(target.captures.test).to(beNil())
                            expect(target.captures.swizzleTest).toNot(beNil())
                        }
                    }
                }
            }

            whenCalled(with: "unknown original selector",
                selectors: #selector(NSString.hasPrefix), #selector(SwizzleTarget.__swizzle_test))
            { getSUTError in

                it("fails") {
                    expect(getSUTError() as? SwizzleFailure) == .methodNotFound
                }
            }

            whenCalled(with: "unknown alternate selector",
                selectors: #selector(SwizzleTarget.test), #selector(NSString.hasPrefix))
            { getSUTError in

                it("fails") {
                    expect(getSUTError() as? SwizzleFailure) == .methodNotFound
                }
            }

            whenCalled(with: "unknown incompatible selectors",
                selectors: #selector(SwizzleTarget.test), #selector(SwizzleTarget.__swizzle_other))
            { getSUTError in

                it("fails") {
                    expect(getSUTError() as? SwizzleFailure) == .typeSignatureDoesNotMatch
                }
            }
        }
    }

    func whenCalled(with description: String, selectors selector1: Selector, _ selector2: Selector, _ body: (@escaping () -> Error?) -> Void) {
        context("called with " + description) {
            var sutError: Error?

            beforeEach {
                do {
                    try swizzle(
                        instanceOf: SwizzleTarget.self,
                        selectors: selector1, selector2
                    )
                } catch {
                    sutError = error
                }
            }

            afterEach {
                sutError = nil
            }

            body({ sutError })
        }
    }
}
