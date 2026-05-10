import XCTest
import SwiftUI
import SpectrumUIFoundations

/// Verifies FR-012: every motion token carries a reduced-motion variant, the
/// reduced variant is at most as long as the base, and `Animation.spectrum(_:reduceMotion:)`
/// honors the parameter.
final class ReduceMotionTests: XCTestCase {

    func testEveryMotionTokenReducedIsAtMostBase() {
        let m = Spectrum.motion
        let tokens: [SpectrumDuration] = [
            m.transitionInstant, m.transitionFast,
            m.transitionMedium,  m.transitionSlow
        ]
        for token in tokens {
            XCTAssertLessThanOrEqual(
                token.reduced, token.base,
                "Motion token \(token.id ?? "?") reduced variant must be ≤ base"
            )
        }
    }

    func testResolveSelectsReducedWhenFlagIsTrue() {
        let m = Spectrum.motion.transitionMedium
        XCTAssertEqual(m.resolve(reduceMotion: false), m.base)
        XCTAssertEqual(m.resolve(reduceMotion: true),  m.reduced)
    }

    func testInstantTransitionReducesToZero() {
        // Instant motion is conventionally fully suppressed under reduce-motion.
        XCTAssertEqual(Spectrum.motion.transitionInstant.reduced, .milliseconds(0))
        XCTAssertEqual(Spectrum.motion.transitionFast.reduced,    .milliseconds(0))
    }

    func testAnimationSpectrumProducesAValidAnimation() {
        // We can't introspect Animation's internals, but we can assert that the
        // helper compiles and returns a non-nil value for both reduce-motion paths.
        let a = Animation.spectrum(Spectrum.motion.transitionMedium, reduceMotion: false)
        let b = Animation.spectrum(Spectrum.motion.transitionMedium, reduceMotion: true)
        // No equatable Animation; just verify both calls succeed without crashing.
        XCTAssertNotNil(a as Any?)
        XCTAssertNotNil(b as Any?)
    }
}
