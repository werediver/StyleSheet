import Quick
import Nimble
@testable import StyleSheet

final class SwizzlingViewInterceptorSpec: QuickSpec {

    func testSpec() { spec() }

    override func spec() {
        describe("SwizzlingViewInterceptor") {
            typealias sut = SwizzlingViewInterceptor
            var sutError: Error?
            var interceptedView: UIView?

            beforeSuite {
                do {
                    try sut.install { interceptedView = $0 }
                } catch {
                    sutError = error
                }
            }

            afterSuite {
                sutError = nil
            }

            afterEach {
                interceptedView = nil
            }

            it("succeds") {
                expect(sutError).to(beNil())
            }

            context("is attempted to be installed again") {

                beforeEach {
                    do {
                        try sut.install(hook: { _ in })
                    } catch {
                        sutError = error
                    }
                }

                afterEach {
                    sutError = nil
                }

                it("fails") {
                    expect(sutError as? SwizzlingViewInterceptor.Failure) == .alreadyInstalled
                }
            }

            context("view did move to window") {
                var window: UIWindow!
                var view: UIView!

                beforeEach {
                    view = UIView(frame: .zero)
                    window = UIWindow(frame: UIScreen.main.bounds)
                    window.addSubview(view)
                }

                afterEach {
                    window = nil
                    view = nil
                }

                it("intercepts view") {
                    expect(interceptedView) === view
                }
            }
        }
    }
}
