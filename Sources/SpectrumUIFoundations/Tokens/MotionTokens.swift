// ============================================================================
// CURATED — v0.2.0 hand-picked subset.
//
// Values trace to Spectrum's published motion guidance. Each token carries a
// reduced-motion variant per FR-012. To be expanded by the generator in v0.2.1.
// ============================================================================

import Foundation

/// Motion tokens. Each token is a ``SpectrumDuration`` carrying a base value and a
/// reduced-motion variant. Apply with `View.transaction { … }` or via the
/// `Animation.spectrum(_:reduceMotion:)` helper.
public struct MotionTokens: Sendable {
    public init() {}

    /// `motion/transition-instant` — 100 ms. Reduced: 0 ms.
    public var transitionInstant: SpectrumDuration {
        SpectrumDuration(
            id: "motion-transition-instant",
            base:    .milliseconds(100),
            reduced: .milliseconds(0)
        )
    }

    /// `motion/transition-fast` — 160 ms. Reduced: 0 ms.
    public var transitionFast: SpectrumDuration {
        SpectrumDuration(
            id: "motion-transition-fast",
            base:    .milliseconds(160),
            reduced: .milliseconds(0)
        )
    }

    /// `motion/transition-medium` — 250 ms. Reduced: 80 ms (cross-fade only).
    public var transitionMedium: SpectrumDuration {
        SpectrumDuration(
            id: "motion-transition-medium",
            base:    .milliseconds(250),
            reduced: .milliseconds(80)
        )
    }

    /// `motion/transition-slow` — 400 ms. Reduced: 80 ms (cross-fade only).
    public var transitionSlow: SpectrumDuration {
        SpectrumDuration(
            id: "motion-transition-slow",
            base:    .milliseconds(400),
            reduced: .milliseconds(80)
        )
    }
}
