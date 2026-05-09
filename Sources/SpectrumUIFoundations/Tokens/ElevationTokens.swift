// ============================================================================
// CURATED — v0.2.0 hand-picked subset.
//
// Values trace to Spectrum's published elevation guidance. Each elevation
// composes geometry + a SpectrumColor for the shadow tint. To be expanded by
// the generator in v0.2.1.
// ============================================================================

import SwiftUI

/// Elevation tokens. Each is a ``SpectrumElevation`` describing the shadow geometry
/// and tint Spectrum specifies.
public struct ElevationTokens: Sendable {
    public init() {}

    private static let shadowColor = SpectrumColor(
        id: "elevation-shadow-color",
        lightHex: 0x66000000,    // 40% black on light
        darkHex:  0x99000000     // 60% black on dark for stronger separation
    )

    /// `elevation/layer-1`. Subtle separation — used for cards on a flat background.
    public var layer1: SpectrumElevation {
        SpectrumElevation(
            id: "elevation-layer-1",
            xOffset: 0, yOffset: 1, blur: 2,
            color: Self.shadowColor, opacity: 0.08
        )
    }

    /// `elevation/layer-2`. Mid-strength separation — popovers, dropdowns.
    public var layer2: SpectrumElevation {
        SpectrumElevation(
            id: "elevation-layer-2",
            xOffset: 0, yOffset: 2, blur: 6,
            color: Self.shadowColor, opacity: 0.12
        )
    }

    /// `elevation/layer-3`. Strong separation — modals, sheets.
    public var layer3: SpectrumElevation {
        SpectrumElevation(
            id: "elevation-layer-3",
            xOffset: 0, yOffset: 8, blur: 24,
            color: Self.shadowColor, opacity: 0.18
        )
    }
}
