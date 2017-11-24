import Quick
import Nimble
import StyleSheet

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

            context("provided with style") {
                var style: StyleMock!
                var setStyleError: Error?

                beforeEach {
                    style = StyleMock()
                    do {
                        try sut.set(style: style)
                    } catch {
                        setStyleError = error
                    }
                }

                afterEach {
                    style = nil
                    setStyleError = nil
                }

                it("succeeds") {
                    expect(setStyleError).to(beNil())
                }

                context("applied to target") {
                    var target: Target!

                    beforeEach {
                        target = Target()
                        sut.apply(to: target)
                    }

                    afterEach {
                        target = nil
                    }

                    it("applies style to target") {
                        expect(style.some) === target
                    }

                    /*
                    context("again applied to same target") {

                        beforeEach {
                            style.some = nil
                            sut.apply(to: target)
                        }

                        it("does not apply style to target") {
                            expect(style.some).to(beNil())
                        }
                    }
                    */
                }

                context("again provided with style") {

                    beforeEach {
                        do {
                            try sut.set(style: style)
                        } catch {
                            setStyleError = error
                        }
                    }

                    it("fails") {
                        expect(setStyleError as? RootStyle.Failure) == .alreadyInitialized
                    }
                }

                context("autoapply set up") {

                    beforeEach {
                        sut.
                    }
                }
            }
        }
    }
}
