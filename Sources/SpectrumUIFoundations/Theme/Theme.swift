import SwiftUI

/// A named rendering context for Spectrum tokens.
///
/// `Theme` captures (a) which built-in baseline (`light` or `dark`) to start from and
/// (b) a sparse set of per-token overrides keyed by token identifier. Tokens not
/// overridden inherit from the baseline.
///
/// Built-in themes:
///
/// - ``Theme/light`` — Spectrum's published light values for every token.
/// - ``Theme/dark`` — Spectrum's published dark values for every token.
///
/// Custom themes carry brand adaptations:
///
/// ```swift
/// let brand = Theme(
///     name: "MyBrand",
///     base: .light,
///     overrides: ThemeOverrides()
///         .colorOverride(id: "accent-color-500",
///                        with: SpectrumColor(lightHex: 0xFF1976D2,
///                                            darkHex:  0xFF42A5F5))
/// )
/// ```
public struct Theme: Equatable, Sendable {
    /// Which built-in baseline this theme customizes.
    public enum Base: String, Sendable, CaseIterable, Equatable {
        case light
        case dark
    }

    /// Human-readable name. Used for diagnostics and equality.
    public let name: String

    /// Baseline scheme. Determines the default color-scheme behavior of the
    /// hosting view tree.
    public let base: Base

    /// Sparse overrides for tokens. Tokens not present here resolve from the
    /// baseline.
    public let overrides: ThemeOverrides

    public init(name: String, base: Base, overrides: ThemeOverrides = ThemeOverrides()) {
        self.name = name
        self.base = base
        self.overrides = overrides
    }

    // Per-category convenience accessors used by the resolution path.
    var colorOverrides: [String: SpectrumColor] { overrides.colors }
    var spacingOverrides: [String: CGFloat] { overrides.spacings }
    var typographyOverrides: [String: SpectrumFont] { overrides.typographies }
    var motionOverrides: [String: SpectrumDuration] { overrides.motions }
    var elevationOverrides: [String: SpectrumElevation] { overrides.elevations }
    var radiusOverrides: [String: CGFloat] { overrides.radii }
    var opacityOverrides: [String: Double] { overrides.opacities }
    var sizingOverrides: [String: CGFloat] { overrides.sizings }
}

/// Sparse map of per-token overrides. Construct with `ThemeOverrides()` for an empty
/// set, then layer overrides via the `…Override(id:with:)` builder methods. Each
/// builder returns a new `ThemeOverrides`; the type is value-immutable.
public struct ThemeOverrides: Equatable, Sendable {
    var colors: [String: SpectrumColor]
    var spacings: [String: CGFloat]
    var typographies: [String: SpectrumFont]
    var motions: [String: SpectrumDuration]
    var elevations: [String: SpectrumElevation]
    var radii: [String: CGFloat]
    var opacities: [String: Double]
    var sizings: [String: CGFloat]

    public init() {
        self.colors = [:]
        self.spacings = [:]
        self.typographies = [:]
        self.motions = [:]
        self.elevations = [:]
        self.radii = [:]
        self.opacities = [:]
        self.sizings = [:]
    }

    /// Override a color token. The `id` MUST match the token's `id` (its source JSON
    /// path). Future versions of this API will replace string IDs with typed key paths
    /// once the generator emits the necessary per-category KeyPath surfaces.
    public func colorOverride(id: String, with color: SpectrumColor) -> ThemeOverrides {
        var copy = self
        copy.colors[id] = color
        return copy
    }

    public func spacingOverride(id: String, with value: CGFloat) -> ThemeOverrides {
        var copy = self
        copy.spacings[id] = value
        return copy
    }

    public func typographyOverride(id: String, with value: SpectrumFont) -> ThemeOverrides {
        var copy = self
        copy.typographies[id] = value
        return copy
    }

    public func motionOverride(id: String, with value: SpectrumDuration) -> ThemeOverrides {
        var copy = self
        copy.motions[id] = value
        return copy
    }

    public func elevationOverride(id: String, with value: SpectrumElevation) -> ThemeOverrides {
        var copy = self
        copy.elevations[id] = value
        return copy
    }

    public func radiusOverride(id: String, with value: CGFloat) -> ThemeOverrides {
        var copy = self
        copy.radii[id] = value
        return copy
    }

    public func opacityOverride(id: String, with value: Double) -> ThemeOverrides {
        var copy = self
        copy.opacities[id] = value
        return copy
    }

    public func sizingOverride(id: String, with value: CGFloat) -> ThemeOverrides {
        var copy = self
        copy.sizings[id] = value
        return copy
    }
}

public extension Theme {
    /// Spectrum's published light theme. All tokens use their light-scheme values; no
    /// overrides.
    static let light = Theme(name: "Spectrum.light", base: .light)

    /// Spectrum's published dark theme. All tokens use their dark-scheme values; no
    /// overrides.
    static let dark = Theme(name: "Spectrum.dark", base: .dark)
}
