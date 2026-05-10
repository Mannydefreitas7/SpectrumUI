import XCTest
import SwiftUI
import SpectrumUIFoundations

/// Verifies FR-001 + FR-015 (non-color categories): every shipped category exposes
/// at least one usable token of the expected Swift type with sane values.
///
/// Color, Dynamic Type, and reduce-motion behavior are covered by their own test
/// files. This file is the catch-all "is each category functional?" suite.
final class CategoryRenderingTests: XCTestCase {

    // MARK: Spacing

    func testSpacingTokensAreFiniteAndMonotonic() {
        let s = Spectrum.spacing
        let series: [CGFloat] = [
            s.s25, s.s50, s.s75, s.s85, s.s100, s.s200, s.s300,
            s.s350, s.s400, s.s500, s.s600, s.s700, s.s800,
            s.s900, s.s1000
        ]
        for v in series {
            XCTAssertTrue(v.isFinite)
            XCTAssertGreaterThanOrEqual(v, 0)
        }
        XCTAssertEqual(series, series.sorted(),
                       "Spacing scale must be non-decreasing")
    }

    // MARK: Sizing (hand-curated)

    func testSizingTokensCoverIconAndControlScales() {
        let s = Spectrum.sizing
        // Control heights typically span 32 → 48 pt.
        XCTAssertGreaterThanOrEqual(s.s200, 24)
        XCTAssertLessThanOrEqual(s.s400, 64)
    }

    // MARK: Radius

    func testRadiusZeroIsZero() {
        XCTAssertEqual(Spectrum.radius.s0, 0)
    }

    func testRadiusGrowsMonotonically() {
        let r = Spectrum.radius
        let series: [CGFloat] = [r.s0, r.s75, r.s100, r.s200, r.s300,
                                 r.s400, r.s500, r.s600, r.s700, r.s800]
        XCTAssertEqual(series, series.sorted())
    }

    // MARK: Opacity

    func testOpacityValuesAreInUnitInterval() {
        let o = Spectrum.opacity
        for v in [o.disabled, o.overlayLight, o.overlayMedium, o.overlayDark,
                  o.hover, o.pressed] {
            XCTAssertGreaterThanOrEqual(v, 0)
            XCTAssertLessThanOrEqual(v, 1)
        }
    }

    func testOpacityOrderingMatchesSemantics() {
        let o = Spectrum.opacity
        XCTAssertLessThan(o.hover, o.pressed,
                          "Pressed state should be more opaque than hover")
        XCTAssertLessThan(o.overlayLight, o.overlayMedium)
        XCTAssertLessThan(o.overlayMedium, o.overlayDark)
    }

    // MARK: Elevation

    func testElevationLayersIncreaseInIntensity() {
        let e = Spectrum.elevation
        XCTAssertLessThan(e.layer1.blur, e.layer2.blur)
        XCTAssertLessThan(e.layer2.blur, e.layer3.blur)
        XCTAssertLessThan(e.layer1.opacity, e.layer3.opacity,
                          "Higher layers cast a stronger shadow")
    }

    func testElevationShadowsHaveAdaptiveColor() {
        // Shadow color is itself a SpectrumColor, so it adapts to color scheme.
        let shadow = Spectrum.elevation.layer2.color
        XCTAssertNotEqual(shadow.lightHex, shadow.darkHex)
    }

    // MARK: Token IDs are unique within a category sample

    func testSampledTokenIDsAreNonNil() {
        XCTAssertNotNil(Spectrum.color.palette.blue.s500.id)
        XCTAssertNotNil(Spectrum.color.text.body.id)
        XCTAssertNotNil(Spectrum.elevation.layer2.id)
        XCTAssertNotNil(Spectrum.motion.transitionMedium.id)
    }
}
