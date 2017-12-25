import Quick
import Nimble
import StyleSheet

final class StyleSheetSpec: QuickSpec {

    func testSpec() { spec() }

    override func spec() {
        describe("StyleSheet") {
            var sut: StyleSheet!
            var styles: [StyleMock]!

            beforeEach {
                styles = [StyleMock(), StyleMock()]
                sut = StyleSheet(styles: styles)
            }

            context("applied to target") {
                var target: BaseStyleTarget!

                beforeEach {
                    target = BaseStyleTarget()
                    sut.apply(to: target!)
                }

                afterEach {
                    target = nil
                }

                it("applies each style to target") {
                    styles.forEach { style in
                        expect(style.captures.apply?.some as? BaseStyleTarget) === target
                    }
                }
            }

            afterEach {
                sut = nil
            }
        }
    }
}
