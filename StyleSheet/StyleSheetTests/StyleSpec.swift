import Quick
import Nimble
import StyleSheet

final class StyleSpec: QuickSpec {

    func testSpec() { spec() }

    override func spec() {
        describe("Style") {
            var sut: Style<Marker, Target>!
            var body: StyleBodyMock<Target>!

            beforeEach {
                body = StyleBodyMock()
                sut = Style(body.apply)
            }

            afterEach {
                sut = nil
            }

            context("applied to marked target") {
                var markedTarget: MarkedTarget!

                beforeEach {
                    markedTarget = MarkedTarget()
                    sut.apply(to: markedTarget)
                }

                afterEach {
                    markedTarget = nil
                }

                it("executes body") {
                    expect(body.target) === markedTarget
                }
            }

            context("applied to non-marked target") {
                var nonMarkedTarget: Target!

                beforeEach {
                    nonMarkedTarget = Target()
                    sut.apply(to: nonMarkedTarget!)
                }

                afterEach {
                    nonMarkedTarget = nil
                }

                it("does not execute body") {
                    expect(body.target).to(beNil())
                }
            }

            context("applied to non-target") {
                let nonTarget: Void

                beforeEach {
                    sut.apply(to: nonTarget)
                }

                it("does not execute body") {
                    expect(body.target).to(beNil())
                }
            }
        }
    }
}
