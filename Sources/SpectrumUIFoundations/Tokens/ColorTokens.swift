// ============================================================================
// CURATED — v0.2.0 hand-picked subset.
//
// Values trace to: Tools/SpectrumTokensSnapshot/color-palette.json (and
// color-aliases.json for semantic tokens). The full Adobe Spectrum color set is
// ~hundreds of tokens; this file ships a usable starter subset and will be
// fully replaced by output from `swift package generate-tokens` in v0.2.1.
//
// Adding more tokens by hand is fine but DO NOT change the existing values —
// edit the JSON snapshot and regenerate (once the generator lands).
// ============================================================================

import SwiftUI

/// Color tokens. Resolves through the active ``Theme`` for per-token overrides;
/// falls back to Spectrum's published values otherwise.
public struct ColorTokens: Sendable {
    public init() {}

    /// Accent color scale (blue family in default Spectrum). Used for primary actions
    /// and accent surfaces.
    public var accent: AccentColors { AccentColors() }

    /// Neutral gray scale. Used for text, backgrounds, borders.
    public var gray: GrayColors { GrayColors() }

    /// Semantic foreground colors (text, icons).
    public var text: TextColors { TextColors() }

    /// Semantic background colors (surfaces, layers).
    public var background: BackgroundColors { BackgroundColors() }

    /// Status colors (success, warning, error). Limited starter set.
    public var status: StatusColors { StatusColors() }
}

/// Accent color shades.
public struct AccentColors: Sendable {
    public init() {}

    /// `blue-500` — `color-palette.json/blue-500`. Light = `rgb(142,185,252)`,
    /// Dark = `rgb(26,58,195)`. Use for tinted backgrounds and hover surfaces.
    public var s500: SpectrumColor {
        SpectrumColor(id: "blue-500", lightHex: 0xFF8EB9FC, darkHex: 0xFF1A3AC3)
    }

    /// `blue-700` — `color-palette.json/blue-700`. Mid-strength accent.
    public var s700: SpectrumColor {
        SpectrumColor(id: "blue-700", lightHex: 0xFF5D89FF, darkHex: 0xFF345BF8)
    }

    /// `blue-900` — `color-palette.json/blue-900`. Primary accent surface.
    public var s900: SpectrumColor {
        SpectrumColor(id: "blue-900", lightHex: 0xFF3B63FB, darkHex: 0xFF5681FF)
    }

    /// `blue-1000` — `color-palette.json/blue-1000`. Strong accent for emphasis.
    public var s1000: SpectrumColor {
        SpectrumColor(id: "blue-1000", lightHex: 0xFF274DEA, darkHex: 0xFF6995FE)
    }
}

/// Neutral gray shades.
public struct GrayColors: Sendable {
    public init() {}

    /// `gray-50` — `color-palette.json/gray-50`. Subtlest off-white background.
    public var s50: SpectrumColor {
        SpectrumColor(id: "gray-50", lightHex: 0xFFF8F8F8, darkHex: 0xFF1B1B1B)
    }

    /// `gray-100` — `color-palette.json/gray-100`. Page/surface background.
    public var s100: SpectrumColor {
        SpectrumColor(id: "gray-100", lightHex: 0xFFE9E9E9, darkHex: 0xFF2C2C2C)
    }

    /// `gray-300` — `color-palette.json/gray-300`. Borders, dividers.
    public var s300: SpectrumColor {
        SpectrumColor(id: "gray-300", lightHex: 0xFFDADADA, darkHex: 0xFF393939)
    }

    /// `gray-500` — `color-palette.json/gray-500`. Disabled or de-emphasized text.
    public var s500: SpectrumColor {
        SpectrumColor(id: "gray-500", lightHex: 0xFF8F8F8F, darkHex: 0xFF6D6D6D)
    }

    /// `gray-700` — `color-palette.json/gray-700`. Muted body copy.
    public var s700: SpectrumColor {
        SpectrumColor(id: "gray-700", lightHex: 0xFF505050, darkHex: 0xFFAFAFAF)
    }

    /// `gray-900` — `color-palette.json/gray-900`. Strong body text.
    public var s900: SpectrumColor {
        SpectrumColor(id: "gray-900", lightHex: 0xFF131313, darkHex: 0xFFF2F2F2)
    }

    /// `gray-1000` — `color-palette.json/gray-1000`. Maximum contrast.
    public var s1000: SpectrumColor {
        SpectrumColor(id: "gray-1000", lightHex: 0xFF000000, darkHex: 0xFFFFFFFF)
    }
}

/// Semantic foreground colors.
public struct TextColors: Sendable {
    public init() {}

    /// Primary body text. Aliases `gray-900`.
    public var body: SpectrumColor {
        SpectrumColor(id: "text-body",
                      lightHex: 0xFF131313, darkHex: 0xFFF2F2F2)
    }

    /// Muted body text. Aliases `gray-700`.
    public var muted: SpectrumColor {
        SpectrumColor(id: "text-muted",
                      lightHex: 0xFF505050, darkHex: 0xFFAFAFAF)
    }

    /// Disabled / de-emphasized text. Aliases `gray-500`.
    public var disabled: SpectrumColor {
        SpectrumColor(id: "text-disabled",
                      lightHex: 0xFF8F8F8F, darkHex: 0xFF6D6D6D)
    }
}

/// Semantic background colors.
public struct BackgroundColors: Sendable {
    public init() {}

    /// Primary page surface. Aliases `gray-50`.
    public var primary: SpectrumColor {
        SpectrumColor(id: "background-primary",
                      lightHex: 0xFFF8F8F8, darkHex: 0xFF1B1B1B)
    }

    /// Layer one (cards, sheets). Aliases `gray-100`.
    public var layer1: SpectrumColor {
        SpectrumColor(id: "background-layer-1",
                      lightHex: 0xFFE9E9E9, darkHex: 0xFF2C2C2C)
    }

    /// Layer two (popovers, menus). Aliases `gray-300`.
    public var layer2: SpectrumColor {
        SpectrumColor(id: "background-layer-2",
                      lightHex: 0xFFDADADA, darkHex: 0xFF393939)
    }
}

/// Status colors.
public struct StatusColors: Sendable {
    public init() {}

    /// Negative / destructive. Aliases `red-700`.
    public var negative: SpectrumColor {
        SpectrumColor(id: "red-700", lightHex: 0xFFFF513D, darkHex: 0xFFCD2E1D)
    }

    /// Positive / success. Aliases `green-700`.
    public var positive: SpectrumColor {
        SpectrumColor(id: "green-700", lightHex: 0xFF0BA45D, darkHex: 0xFF047C4B)
    }
}
