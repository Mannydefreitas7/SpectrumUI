// ============================================================================
// CURATED — v0.2.0 hand-picked subset.
//
// Values trace to Spectrum's published opacity guidance.
// To be expanded by the generator in v0.2.1.
// ============================================================================

/// Opacity tokens (`Double`, 0.0 – 1.0).
public struct OpacityTokens: Sendable {
    public init() {}

    /// `opacity-disabled`. Standard disabled-state opacity. 0.4.
    public var disabled: Double { 0.4 }

    /// `opacity-overlay-light`. Modal scrim, light variant. 0.30.
    public var overlayLight: Double { 0.30 }

    /// `opacity-overlay-medium`. Modal scrim, default variant. 0.55.
    public var overlayMedium: Double { 0.55 }

    /// `opacity-overlay-dark`. Modal scrim, strong variant. 0.75.
    public var overlayDark: Double { 0.75 }

    /// `opacity-hover`. Hover-state tint. 0.08.
    public var hover: Double { 0.08 }

    /// `opacity-pressed`. Active/pressed tint. 0.16.
    public var pressed: Double { 0.16 }
}
