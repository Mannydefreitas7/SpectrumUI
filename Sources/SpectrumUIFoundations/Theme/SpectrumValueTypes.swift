import SwiftUI

/// A Spectrum typography token.
///
/// Combines a SwiftUI `Font` with optional Dynamic Type anchoring (`textStyle`) and the
/// extra geometric properties Spectrum specifies — `lineHeight` and `tracking` — that
/// SwiftUI does not expose directly on `Font`. Apply via the `View.spectrumFont(_:)`
/// extension to get all properties wired up at once.
public struct SpectrumFont: Equatable, Sendable {
    public let id: String?
    public let base: Font
    public let textStyle: Font.TextStyle?
    public let lineHeight: CGFloat?
    public let tracking: CGFloat?

    public init(
        id: String? = nil,
        base: Font,
        textStyle: Font.TextStyle? = nil,
        lineHeight: CGFloat? = nil,
        tracking: CGFloat? = nil
    ) {
        self.id = id
        self.base = base
        self.textStyle = textStyle
        self.lineHeight = lineHeight
        self.tracking = tracking
    }
}

/// A Spectrum motion token. Carries both a base duration and a reduced-motion variant.
///
/// Use `View.spectrumAnimation(_:)` to get an `Animation` that automatically resolves
/// against `EnvironmentValues.accessibilityReduceMotion`. Or call `resolve(reduceMotion:)`
/// directly when integrating with non-SwiftUI animation systems.
public struct SpectrumDuration: Equatable, Sendable {
    public let id: String?
    public let base: Duration
    public let reduced: Duration

    public init(id: String? = nil, base: Duration, reduced: Duration) {
        self.id = id
        self.base = base
        self.reduced = reduced
    }

    /// Returns `reduced` when the user has enabled the reduce-motion accessibility
    /// preference, otherwise `base`.
    public func resolve(reduceMotion: Bool) -> Duration {
        reduceMotion ? reduced : base
    }
}

/// A Spectrum elevation token. Captures the full shadow geometry Spectrum specifies.
///
/// Apply via `View.shadow(...)` — the elevation token's properties map directly:
///
/// ```swift
/// myView.shadow(
///     color: Spectrum.elevation.layer2.color.color(for: .light),
///     radius: Spectrum.elevation.layer2.blur,
///     x: Spectrum.elevation.layer2.xOffset,
///     y: Spectrum.elevation.layer2.yOffset
/// )
/// ```
public struct SpectrumElevation: Equatable, Sendable {
    public let id: String?
    public let xOffset: CGFloat
    public let yOffset: CGFloat
    public let blur: CGFloat
    public let color: SpectrumColor
    public let opacity: Double

    public init(
        id: String? = nil,
        xOffset: CGFloat,
        yOffset: CGFloat,
        blur: CGFloat,
        color: SpectrumColor,
        opacity: Double
    ) {
        self.id = id
        self.xOffset = xOffset
        self.yOffset = yOffset
        self.blur = blur
        self.color = color
        self.opacity = opacity
    }
}
