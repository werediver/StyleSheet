import Quick
import Nimble
import StyleSheet

final class StyleSpec: QuickSpec {

    func testSpec() { spec() }

    override func spec() {
        describe("Style") {
            var sut: Style<StyleMarker, BaseStyleTarget>!
            var body: StyleBodyMock<BaseStyleTarget>!

            beforeEach {
                body = StyleBodyMock()
                sut = Style(body.apply)
            }

            afterEach {
                sut = nil
            }

            context("applied to marked target") {
                var markedTarget: MarkedStyleTarget!

                beforeEach {
                    markedTarget = MarkedStyleTarget()
                    sut.apply(to: markedTarget)
                }

                afterEach {
                    markedTarget = nil
                }

                it("executes body") {
                    expect(body.captures.apply?.target) === markedTarget
                }
            }

            context("applied to non-marked target") {
                var nonMarkedTarget: BaseStyleTarget!

                beforeEach {
                    nonMarkedTarget = BaseStyleTarget()
                    sut.apply(to: nonMarkedTarget!)
                }

                afterEach {
                    nonMarkedTarget = nil
                }

                it("does not execute body") {
                    expect(body.captures.apply?.target).to(beNil())
                }
            }

            context("applied to non-target") {
                let nonTarget: Void

                beforeEach {
                    sut.apply(to: nonTarget)
                }

                it("does not execute body") {
                    expect(body.captures.apply?.target).to(beNil())
                }
            }
        }
    }
}
