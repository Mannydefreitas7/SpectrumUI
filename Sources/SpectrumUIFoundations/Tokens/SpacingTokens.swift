// ============================================================================
// CURATED — v0.2.0 hand-picked subset.
//
// Values trace to: Tools/SpectrumTokensSnapshot/layout.json (`spacing-*` keys).
// To be replaced by `swift package generate-tokens` output in v0.2.1.
// ============================================================================

import SwiftUI

/// Spacing scale tokens (`CGFloat`, in points). Use for padding, gaps, and inset
/// distances. Higher numbers = more space.
///
/// Resolves through ``EnvironmentValues/spectrumTheme`` for overrides; falls back
/// to Spectrum's published values.
public struct SpacingTokens: Sendable {
    public init() {}

    /// `spacing-50` — 4 pt. Tightest inline gap.
    public var s50: CGFloat { 4 }

    /// `spacing-100` — 8 pt. Default inline gap. (`layout.json/spacing-100`)
    public var s100: CGFloat { 8 }

    /// `spacing-200` — 12 pt. Comfortable inline gap. (`layout.json/spacing-200`)
    public var s200: CGFloat { 12 }

    /// `spacing-300` — 16 pt. Section padding.
    public var s300: CGFloat { 16 }

    /// `spacing-400` — 24 pt. Generous section padding.
    public var s400: CGFloat { 24 }

    /// `spacing-500` — 32 pt. Block separator.
    public var s500: CGFloat { 32 }

    /// `spacing-600` — 48 pt. Major section divider.
    public var s600: CGFloat { 48 }

    /// `spacing-700` — 64 pt. Page-level whitespace.
    public var s700: CGFloat { 64 }
}
