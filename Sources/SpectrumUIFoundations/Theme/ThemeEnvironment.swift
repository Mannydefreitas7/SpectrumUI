import SwiftUI

/// SwiftUI `Environment` key carrying the active SpectrumUI theme.
private struct SpectrumThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .light
}

public extension EnvironmentValues {
    /// The active SpectrumUI theme. Defaults to ``Theme/light``. Apply a custom theme
    /// via `View.spectrumTheme(_:)`.
    var spectrumTheme: Theme {
        get { self[SpectrumThemeKey.self] }
        set { self[SpectrumThemeKey.self] = newValue }
    }
}

public extension View {
    /// Apply a SpectrumUI theme to this view's subtree.
    ///
    /// Descendant views consuming Spectrum tokens resolve their values against this
    /// theme. Sibling subtrees outside this scope keep the default or their own
    /// applied theme.
    func spectrumTheme(_ theme: Theme) -> some View {
        environment(\.spectrumTheme, theme)
    }

    /// Apply a Spectrum typography token to this view's content.
    ///
    /// Wires the token's `font`, `tracking`, and (where supported) line-height in one
    /// call, so consumers don't have to remember which SwiftUI modifier corresponds to
    /// which typography property.
    @ViewBuilder
    func spectrumFont(_ font: SpectrumFont) -> some View {
        let view = self.font(font.base)
        if let tracking = font.tracking {
            view.tracking(tracking)
        } else {
            view
        }
    }
}

/// Animation helpers for Spectrum motion tokens.
public extension Animation {
    /// Build an `Animation` from a Spectrum motion token, honoring the user's
    /// reduce-motion accessibility preference.
    ///
    /// In a SwiftUI view context, prefer `.spectrumAnimation(_:)` on the view —
    /// it reads `\.accessibilityReduceMotion` from the environment for you.
    static func spectrum(_ duration: SpectrumDuration, reduceMotion: Bool = false) -> Animation {
        let resolved = duration.resolve(reduceMotion: reduceMotion)
        return .easeInOut(duration: TimeInterval(resolved.components.seconds)
            + TimeInterval(resolved.components.attoseconds) / 1e18)
    }
}
