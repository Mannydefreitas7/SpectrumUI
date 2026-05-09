import XCTest
import SwiftUI
@testable import SpectrumUIFoundations

final class SpectrumUIFoundationsTests: XCTestCase {

    // MARK: Namespace presence

    func testEightCategoriesAreReachable() {
        // All eight Spectrum.* category accessors must compile and produce a value.
        _ = Spectrum.color
        _ = Spectrum.spacing
        _ = Spectrum.typography
        _ = Spectrum.motion
        _ = Spectrum.elevation
        _ = Spectrum.radius
        _ = Spectrum.opacity
        _ = Spectrum.sizing
    }

    // MARK: Token sanity

    func testSpacingScaleIsMonotonicallyIncreasing() {
        let s = Spectrum.spacing
        let scale: [CGFloat] = [s.s50, s.s100, s.s200, s.s300, s.s400, s.s500, s.s600, s.s700]
        XCTAssertEqual(scale, scale.sorted(), "Spacing scale must be non-decreasing")
        XCTAssertGreaterThan(s.s50, 0)
        XCTAssertGreaterThan(s.s700, s.s50)
    }

    func testSizingScaleIsMonotonicallyIncreasing() {
        let s = Spectrum.sizing
        let scale: [CGFloat] = [s.s50, s.s100, s.s200, s.s300, s.s400, s.s500, s.s600]
        XCTAssertEqual(scale, scale.sorted())
    }

    func testRadiusScaleIsMonotonicallyIncreasing() {
        let r = Spectrum.radius
        let scale: [CGFloat] = [r.s50, r.s100, r.s200, r.s300, r.s400, r.s500]
        XCTAssertEqual(scale, scale.sorted())
        XCTAssertGreaterThan(r.full, r.s500, "full corner radius must be the largest")
    }

    func testOpacityValuesInRange() {
        let o = Spectrum.opacity
        for v in [o.disabled, o.overlayLight, o.overlayMedium, o.overlayDark, o.hover, o.pressed] {
            XCTAssertGreaterThanOrEqual(v, 0.0)
            XCTAssertLessThanOrEqual(v, 1.0)
        }
    }

    // MARK: SpectrumColor identity & resolution

    func testSpectrumColorCarriesItsTokenIdentifier() {
        let c = Spectrum.color.accent.s500
        XCTAssertEqual(c.id, "blue-500")
        XCTAssertNotEqual(c.lightHex, c.darkHex,
                          "Light and dark hex must differ for an adaptive token")
    }

    func testGray1000IsBlackInLightAndWhiteInDark() {
        // gray-1000 is the canonical max-contrast token: black on light, white on dark.
        let c = Spectrum.color.gray.s1000
        XCTAssertEqual(c.lightHex, 0xFF000000)
        XCTAssertEqual(c.darkHex,  0xFFFFFFFF)
    }

    // MARK: Theme

    func testBuiltInThemes() {
        XCTAssertEqual(Theme.light.name, "Spectrum.light")
        XCTAssertEqual(Theme.light.base, .light)
        XCTAssertEqual(Theme.dark.name,  "Spectrum.dark")
        XCTAssertEqual(Theme.dark.base,  .dark)
    }

    func testThemeDefaultsHaveNoOverrides() {
        XCTAssertTrue(Theme.light.colorOverrides.isEmpty)
        XCTAssertTrue(Theme.dark.colorOverrides.isEmpty)
    }

    func testColorOverrideRoundTrip() {
        let custom = SpectrumColor(lightHex: 0xFF1976D2, darkHex: 0xFF42A5F5)
        let theme = Theme(
            name: "MyBrand",
            base: .light,
            overrides: ThemeOverrides().colorOverride(id: "blue-500", with: custom)
        )
        XCTAssertEqual(theme.colorOverrides["blue-500"], custom)
        XCTAssertNil(theme.colorOverrides["blue-700"])
    }

    // MARK: SpectrumDuration

    func testReduceMotionResolution() {
        let d = Spectrum.motion.transitionMedium
        XCTAssertEqual(d.resolve(reduceMotion: false), d.base)
        XCTAssertEqual(d.resolve(reduceMotion: true),  d.reduced)
        XCTAssertLessThan(d.reduced, d.base)
    }
}
