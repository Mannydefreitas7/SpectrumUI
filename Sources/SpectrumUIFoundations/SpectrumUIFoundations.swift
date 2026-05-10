/// Root namespace for the Foundations layer of SpectrumUI.
///
/// Foundations exposes Adobe Spectrum's design tokens — color, spacing, typography,
/// motion, elevation, radius, opacity, and sizing — as typed, SwiftUI-native values.
/// The single entry point is ``Spectrum``.
///
/// ```swift
/// import SwiftUI
/// import SpectrumUIFoundations
///
/// struct CardView: View {
///     var body: some View {
///         Text("Hello")
///             .padding(Spectrum.spacing.s400)
///             .background(
///                 Spectrum.color.background.primary,
///                 in: .rect(cornerRadius: Spectrum.radius.s200)
///             )
///     }
/// }
/// ```
public enum SpectrumUIFoundations {}

/// Top-level entry namespace for every SpectrumUI design token.
///
/// Token access is hierarchical — `Spectrum.color.accent.s500` reaches the accent-color
/// 500 shade, `Spectrum.spacing.s200` reaches the spacing scale's 200-step value, and
/// so on. Numeric Spectrum scale values use the ``s<N>`` form because Swift identifiers
/// cannot start with a digit; the rest of the path mirrors Spectrum's published JSON
/// hierarchy.
public enum Spectrum {
    /// Color tokens. Adapt automatically to the SwiftUI `ColorScheme`.
    public static var color: ColorTokens { ColorTokens() }

    /// Spacing scale tokens (`CGFloat`, in points).
    public static var spacing: SpacingTokens { SpacingTokens() }

    /// Typography tokens. ``SpectrumFont`` values that bridge to Dynamic Type on iOS.
    public static var typography: TypographyTokens { TypographyTokens() }

    /// Motion tokens. ``SpectrumDuration`` values that respect the user's
    /// reduce-motion accessibility preference.
    public static var motion: MotionTokens { MotionTokens() }

    /// Elevation tokens. ``SpectrumElevation`` values describing shadow geometry.
    public static var elevation: ElevationTokens { ElevationTokens() }

    /// Corner-radius tokens (`CGFloat`, in points).
    public static var radius: RadiusTokens { RadiusTokens() }

    /// Opacity tokens (`Double`, 0.0 to 1.0).
    public static var opacity: OpacityTokens { OpacityTokens() }

    /// Sizing tokens (`CGFloat`, in points). Used for component dimensions.
    public static var sizing: SizingTokens { SizingTokens() }
}
