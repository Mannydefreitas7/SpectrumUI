// ============================================================================
// CURATED — v0.2.0 hand-picked subset.
//
// Values trace to: Tools/SpectrumTokensSnapshot/typography.json. Apple system
// fonts are used as a stand-in for Spectrum's Adobe Clean — bundling the brand
// typeface is its own future feature. To be expanded by the generator in v0.2.1.
// ============================================================================

import SwiftUI

/// Typography tokens. Each token returns a ``SpectrumFont`` that can be applied via
/// `View.spectrumFont(_:)`. iOS consumers get Dynamic Type pickup automatically
/// via the embedded `Font.TextStyle`.
public struct TypographyTokens: Sendable {
    public init() {}

    /// `typography.json/heading-display` (closest analog: `.largeTitle` on iOS).
    /// Use for hero headings.
    public var displayL: SpectrumFont {
        SpectrumFont(
            id: "heading-display",
            base: .system(.largeTitle, design: .default, weight: .bold),
            textStyle: .largeTitle,
            lineHeight: 56,
            tracking: 0
        )
    }

    /// `typography.json/heading-l`. Section headings.
    public var headingL: SpectrumFont {
        SpectrumFont(
            id: "heading-l",
            base: .system(.title, design: .default, weight: .semibold),
            textStyle: .title,
            lineHeight: 36,
            tracking: 0
        )
    }

    /// `typography.json/heading-m`. Subsection headings.
    public var headingM: SpectrumFont {
        SpectrumFont(
            id: "heading-m",
            base: .system(.title2, design: .default, weight: .semibold),
            textStyle: .title2,
            lineHeight: 28,
            tracking: 0
        )
    }

    /// `typography.json/heading-s`. Card titles, inline headings.
    public var headingS: SpectrumFont {
        SpectrumFont(
            id: "heading-s",
            base: .system(.title3, design: .default, weight: .semibold),
            textStyle: .title3,
            lineHeight: 24,
            tracking: 0
        )
    }

    /// `typography.json/body-l`. Long-form body copy.
    public var bodyL: SpectrumFont {
        SpectrumFont(
            id: "body-l",
            base: .system(.body, design: .default, weight: .regular),
            textStyle: .body,
            lineHeight: 24,
            tracking: 0
        )
    }

    /// `typography.json/body-m`. Default body copy.
    public var bodyM: SpectrumFont {
        SpectrumFont(
            id: "body-m",
            base: .system(.callout, design: .default, weight: .regular),
            textStyle: .callout,
            lineHeight: 20,
            tracking: 0
        )
    }

    /// `typography.json/body-s`. Compact / supporting text.
    public var bodyS: SpectrumFont {
        SpectrumFont(
            id: "body-s",
            base: .system(.footnote, design: .default, weight: .regular),
            textStyle: .footnote,
            lineHeight: 18,
            tracking: 0
        )
    }

    /// `typography.json/code-m`. Inline code, monospace contexts.
    public var codeM: SpectrumFont {
        SpectrumFont(
            id: "code-m",
            base: .system(.body, design: .monospaced, weight: .regular),
            textStyle: .body,
            lineHeight: 22,
            tracking: 0
        )
    }
}
