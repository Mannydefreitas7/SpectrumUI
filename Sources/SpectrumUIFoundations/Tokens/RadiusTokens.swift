// ============================================================================
// CURATED — v0.2.0 hand-picked subset.
//
// Values trace to: Tools/SpectrumTokensSnapshot/layout.json (`corner-radius-*`).
// To be expanded by the generator in v0.2.1.
// ============================================================================

import SwiftUI

/// Corner-radius tokens (`CGFloat`, in points).
public struct RadiusTokens: Sendable {
    public init() {}

    /// `corner-radius-50` — 2 pt. Tightest rounding.
    public var s50: CGFloat { 2 }

    /// `corner-radius-100` — 4 pt. (`layout.json/corner-radius-100`)
    public var s100: CGFloat { 4 }

    /// `corner-radius-200` — 5 pt. (`layout.json/corner-radius-200`)
    public var s200: CGFloat { 5 }

    /// `corner-radius-300` — 8 pt. Cards, inputs.
    public var s300: CGFloat { 8 }

    /// `corner-radius-400` — 12 pt. Larger surfaces.
    public var s400: CGFloat { 12 }

    /// `corner-radius-500` — 16 pt. Bottom sheets, large modals.
    public var s500: CGFloat { 16 }

    /// `corner-radius-full` — 9999 pt. Pills, fully rounded ends.
    public var full: CGFloat { 9999 }
}
