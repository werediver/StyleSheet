import Quick
import Nimble
@testable import StyleSheet

final class RootStyleSpec: QuickSpec {

    func testSpec() { spec() }

    override func spec() {
        describe("RootStyle") {
            var sut: RootStyle!

            beforeEach {
                sut = RootStyle()
            }

            afterEach {
                sut = nil
            }

            context("autoapply set up") {
                var style: StyleMock!
                var viewInterceptorClass: ViewInterceptorMock.Type!
                var autoapplyError: Error?

                beforeEach {
                    style = StyleMock()
                    viewInterceptorClass = ViewInterceptorMock.self
                    do {
                        try sut.autoapply(style: style, method: .custom(viewInterceptorClass))
                    } catch {
                        autoapplyError = error
                    }
                }

                afterEach {
                    style = nil
                    viewInterceptorClass = nil
                    autoapplyError = nil
                }

                it("succeeds") {
                    expect(autoapplyError).to(beNil())
                }

                it("installs hook") {
                    expect(viewInterceptorClass.captures.install).toNot(beNil())
                }

                context("autoapply set up more than once") {

                    beforeEach {
                        do {
                            try sut.autoapply(style: style)
                        } catch {
                            autoapplyError = error
                        }
                    }

                    it("fails") {
                        expect(autoapplyError as? RootStyle.Failure) == .alreadySetup
                    }
                }

                context("view intercepted") {
                    var view: UIView!

                    beforeEach {
                        view = UIView(frame: .zero)
                        viewInterceptorClass.captures.install?.hook(view)
                    }

                    afterEach {
                        view = nil
                    }

                    it("applies style") {
                        expect(style.captures.apply?.some) === view
                    }
                }
            }
        }
    }
}
