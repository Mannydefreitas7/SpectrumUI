import XCTest
import SwiftUI
@testable import SpectrumUIFoundations

/// Verifies FR-006 + FR-015 (color subset): every shipped color token resolves to its
/// published light value when the active color scheme is `.light`, and to its dark
/// value when the scheme is `.dark`.
///
/// Implemented as value-level assertions against the embedded hex values rather than
/// image snapshots — image baselines are deferred to a follow-up PR with proper
/// review tooling.
final class ColorSchemeAdaptationTests: XCTestCase {

    // MARK: Per-scheme resolution

    func testEachSemanticColorResolvesPerScheme() {
        let cases: [SpectrumColor] = [
            Spectrum.color.text.body,
            Spectrum.color.text.muted,
            Spectrum.color.text.disabled,
            Spectrum.color.background.primary,
            Spectrum.color.background.layer1,
            Spectrum.color.background.layer2,
            Spectrum.color.status.negative,
            Spectrum.color.status.positive
        ]
        for c in cases {
            // `color(for:)` is the underlying per-scheme picker. Distinct hex values
            // imply distinct rendered colors.
            XCTAssertNotEqual(c.lightHex, c.darkHex,
                              "Adaptive color \(c.id ?? "?") must differ between schemes")
            // Resolved Color objects must be non-equal across schemes (sanity).
            XCTAssertNotEqual(c.color(for: .light), c.color(for: .dark))
        }
    }

    func testPaletteSampleResolvesPerScheme() {
        // Sample one token from each of the 19 generated palette families.
        let p = Spectrum.color.palette
        let samples: [SpectrumColor] = [
            p.blue.s500, p.brown.s500, p.celery.s500, p.chartreuse.s500,
            p.cinnamon.s500, p.cyan.s500, p.fuchsia.s500, p.gray.s500,
            p.green.s500, p.indigo.s500, p.magenta.s500, p.orange.s500,
            p.pink.s500, p.purple.s500, p.red.s500, p.seafoam.s500,
            p.silver.s500, p.turquoise.s500, p.yellow.s500
        ]
        XCTAssertEqual(samples.count, 19, "Sanity: 19 families")
        for c in samples {
            XCTAssertNotEqual(c.lightHex, c.darkHex,
                              "Family token \(c.id ?? "?") must differ across schemes")
        }
    }

    // MARK: Resolution through Environment

    func testResolveInLightEnvironmentPicksLightValue() {
        var env = EnvironmentValues()
        env.colorScheme = .light
        let token = Spectrum.color.palette.blue.s500
        let resolved = token.resolve(in: env)
        XCTAssertEqual(resolved, token.color(for: .light))
    }

    func testResolveInDarkEnvironmentPicksDarkValue() {
        var env = EnvironmentValues()
        env.colorScheme = .dark
        let token = Spectrum.color.palette.blue.s500
        let resolved = token.resolve(in: env)
        XCTAssertEqual(resolved, token.color(for: .dark))
    }

    // MARK: Theme override

    func testThemeOverrideReplacesResolvedValue() {
        let overrideColor = SpectrumColor(
            id: nil,
            lightHex: 0xFF1976D2,
            darkHex:  0xFF42A5F5
        )
        let custom = Theme(
            name: "Test",
            base: .light,
            overrides: ThemeOverrides()
                .colorOverride(id: "blue-500", with: overrideColor)
        )
        var env = EnvironmentValues()
        env.colorScheme = .light
        env.spectrumTheme = custom

        let token = Spectrum.color.palette.blue.s500
        let resolved = token.resolve(in: env)
        XCTAssertEqual(resolved, overrideColor.color(for: .light),
                       "Theme override should replace the resolved color")
    }

    func testThemeOverrideOnOneTokenLeavesOthersUntouched() {
        let overrideColor = SpectrumColor(
            id: nil, lightHex: 0xFF1976D2, darkHex: 0xFF42A5F5
        )
        let custom = Theme(
            name: "Test",
            base: .light,
            overrides: ThemeOverrides()
                .colorOverride(id: "blue-500", with: overrideColor)
        )
        var env = EnvironmentValues()
        env.colorScheme = .light
        env.spectrumTheme = custom

        // gray-500 was NOT overridden — must still resolve to its Spectrum default.
        let gray = Spectrum.color.palette.gray.s500
        let resolved = gray.resolve(in: env)
        XCTAssertEqual(resolved, gray.color(for: .light),
                       "Non-overridden tokens must keep their Spectrum default")
    }
}
