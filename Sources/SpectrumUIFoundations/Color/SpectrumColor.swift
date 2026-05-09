import SwiftUI

/// A Spectrum color token. Renders adaptively for light and dark color schemes.
///
/// `SpectrumColor` carries two raw color values — one for light, one for dark — plus an
/// optional identifier used to look up theme-level overrides. It conforms to
/// SwiftUI's `ShapeStyle`, so consumers can use it anywhere a `ShapeStyle` is accepted:
///
/// ```swift
/// Text("Hi").foregroundStyle(Spectrum.color.text.body)
/// Rectangle().fill(Spectrum.color.background.primary)
/// ```
///
/// Hex format is `0xAARRGGBB` — alpha in the highest byte. An alpha of `0xFF` means
/// fully opaque.
public struct SpectrumColor: ShapeStyle, Equatable, Sendable {
    /// Stable token identifier (the path in the source Spectrum JSON, e.g.
    /// `"accent-color-500"`). `nil` for ad-hoc colors constructed by consumers as
    /// theme overrides.
    public let id: String?

    /// Color value in the `light` color scheme, packed as `0xAARRGGBB`.
    public let lightHex: UInt32

    /// Color value in the `dark` color scheme, packed as `0xAARRGGBB`.
    public let darkHex: UInt32

    public init(id: String? = nil, lightHex: UInt32, darkHex: UInt32) {
        self.id = id
        self.lightHex = lightHex
        self.darkHex = darkHex
    }

    /// SwiftUI `ShapeStyle` resolution. Picks the per-scheme hex, applies any active
    /// theme override, and returns a `Color`.
    public func resolve(in environment: EnvironmentValues) -> Color {
        let theme = environment.spectrumTheme
        if let id, let override = theme.colorOverrides[id] {
            return override.color(for: environment.colorScheme)
        }
        return color(for: environment.colorScheme)
    }

    /// Direct color lookup without going through theme overrides. Internal helper for
    /// tests and the resolution path.
    func color(for scheme: ColorScheme) -> Color {
        let hex = scheme == .dark ? darkHex : lightHex
        let a = Double((hex >> 24) & 0xFF) / 255.0
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >>  8) & 0xFF) / 255.0
        let b = Double( hex        & 0xFF) / 255.0
        return Color(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
