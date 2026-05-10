import XCTest
import SwiftUI
import SpectrumUIFoundations

/// Verifies FR-011: typography tokens preserve a `Font.TextStyle` anchor so iOS
/// Dynamic Type scaling works automatically. We don't measure actual rendered sizes
/// (that's SwiftUI's job and platform-specific) — we verify our tokens carry the
/// metadata SwiftUI needs to do the right thing.
final class DynamicTypeTests: XCTestCase {

    func testEveryShippedTypographyTokenCarriesATextStyle() {
        let t = Spectrum.typography
        let tokens: [SpectrumFont] = [
            t.displayL, t.headingL, t.headingM, t.headingS,
            t.bodyL, t.bodyM, t.bodyS, t.codeM
        ]
        for token in tokens {
            XCTAssertNotNil(
                token.textStyle,
                "Typography token \(token.id ?? "?") must carry a Font.TextStyle " +
                "for Dynamic Type pickup on iOS (FR-011)."
            )
        }
    }

    func testHeadingsUseHeadlineFamilyTextStyles() {
        // Sanity: headings should map to headline-family TextStyles, not body styles.
        // The exact mapping is documented in the token's source comment; this test
        // catches regressions where, say, headingL got set to .body by accident.
        let headlineStyles: Set<Font.TextStyle> = [
            .largeTitle, .title, .title2, .title3, .headline
        ]
        XCTAssertTrue(headlineStyles.contains(Spectrum.typography.headingL.textStyle!))
        XCTAssertTrue(headlineStyles.contains(Spectrum.typography.headingM.textStyle!))
        XCTAssertTrue(headlineStyles.contains(Spectrum.typography.headingS.textStyle!))
    }

    func testBodyStylesUseBodyFamilyTextStyles() {
        let bodyStyles: Set<Font.TextStyle> = [.body, .callout, .footnote, .subheadline]
        XCTAssertTrue(bodyStyles.contains(Spectrum.typography.bodyL.textStyle!))
        XCTAssertTrue(bodyStyles.contains(Spectrum.typography.bodyM.textStyle!))
        XCTAssertTrue(bodyStyles.contains(Spectrum.typography.bodyS.textStyle!))
    }
}
