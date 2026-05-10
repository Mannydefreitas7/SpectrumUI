// ============================================================================
// CURATED — v0.2.0 hand-picked subset.
//
// Values trace to: Tools/SpectrumTokensSnapshot/layout.json (`size-*`).
// To be expanded by the generator in v0.2.1.
// ============================================================================

import SwiftUI

/// Sizing tokens (`CGFloat`, in points). Used for component dimensions: control
/// heights, icon sizes, target areas.
public struct SizingTokens: Sendable {
    public init() {}

    /// `size-50` — 16 pt. Tiny icon size.
    public var s50: CGFloat { 16 }

    /// `size-100` — 24 pt. Default icon size.
    public var s100: CGFloat { 24 }

    /// `size-200` — 32 pt. Compact control height.
    public var s200: CGFloat { 32 }

    /// `size-300` — 40 pt. Default control height.
    public var s300: CGFloat { 40 }

    /// `size-400` — 48 pt. Comfortable control height.
    public var s400: CGFloat { 48 }

    /// `size-500` — 56 pt. Hero control height.
    public var s500: CGFloat { 56 }

    /// `size-600` — 64 pt. Avatar / large media.
    public var s600: CGFloat { 64 }
}
