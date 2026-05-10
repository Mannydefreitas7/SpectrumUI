// ============================================================================
// HAND-CURATED — semantic color shortcuts.
//
// Raw Spectrum palette colors are GENERATED into ColorPaletteTokens.swift.
// This file declares the ``ColorTokens`` struct itself plus the small set of
// semantic groupings (text/background/status) that consumers reach for directly.
// Each semantic accessor returns a SpectrumColor whose values mirror a specific
// palette token — keep them in sync if the palette is regenerated.
// ============================================================================

import SwiftUI

/// Color tokens. Reachable via ``Spectrum/color``.
///
/// - Use the semantic shortcuts (``text``, ``background``, ``status``) for the most
///   common needs. They are stable across releases and map to specific palette tokens.
/// - Use ``palette`` (extension in `ColorPaletteTokens.swift`) for direct access to
///   the full Adobe Spectrum color palette — 19 families, ~16 shades each.
public struct ColorTokens: Sendable {
    public init() {}

    /// Semantic foreground colors (text, icons).
    public var text: TextColors { TextColors() }

    /// Semantic background colors (surfaces, layers).
    public var background: BackgroundColors { BackgroundColors() }

    /// Status colors (success, warning, error). Limited starter set.
    public var status: StatusColors { StatusColors() }
}

/// Semantic foreground colors. Values mirror specific palette tokens.
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

/// Semantic background colors. Values mirror specific palette tokens.
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

/// Status colors. Values mirror specific palette tokens.
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
