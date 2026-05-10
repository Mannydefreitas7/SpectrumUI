# ``SpectrumUIFoundations``

The Foundations layer of SpectrumUI: design tokens, theme primitives, and SwiftUI Environment integration consumed by every higher layer.

## Overview

Foundations is the bottom of the SpectrumUI stack. As of v0.2.0 it exposes a real token system covering all eight Spectrum categories — color, spacing, typography, motion, elevation, radius, opacity, and sizing — through a single typed entry point: `Spectrum`.

```swift
import SwiftUI
import SpectrumUIFoundations

Text("Hi")
    .spectrumFont(Spectrum.typography.bodyM)
    .foregroundStyle(Spectrum.color.text.body)
    .padding(Spectrum.spacing.s200)
```

Every color token resolves adaptively against the active SwiftUI `ColorScheme` — you write `Spectrum.color.text.body` once and the renderer returns the published light or dark value automatically.

## Topics

### Token categories

- ``Spectrum``
- ``ColorTokens``
- ``ColorPalette``
- ``SpacingTokens``
- ``TypographyTokens``
- ``MotionTokens``
- ``ElevationTokens``
- ``RadiusTokens``
- ``OpacityTokens``
- ``SizingTokens``

### Token value types

- ``SpectrumColor``
- ``SpectrumFont``
- ``SpectrumDuration``
- ``SpectrumElevation``

### Theming

- ``Theme``
- ``ThemeOverrides``
- `EnvironmentValues/spectrumTheme`

### View modifiers

- `View/spectrumTheme(_:)`
- `View/spectrumFont(_:)`
- `Animation/spectrum(_:reduceMotion:)`

## Color

Color tokens come in two shapes:

- **Semantic shortcuts** — `Spectrum.color.text.body`, `.background.primary`, `.status.negative`. These are stable across releases and map to specific palette tokens.
- **Full palette** — `Spectrum.color.palette.<family>.s<N>` reaches the published Adobe Spectrum palette: 19 families (blue, gray, red, green, …), each with ~16 shades. Generated directly from `color-palette.json` and traced back to it via the token's `id`.

All color tokens are `SpectrumColor` values that conform to `ShapeStyle`, so they slot into `.foregroundStyle(_:)`, `.fill(_:)`, `.background(_:)`, and similar SwiftUI APIs.

## Theming

A `Theme` selects a baseline (`.light` or `.dark`) and carries a sparse `ThemeOverrides` map. Apply via `View.spectrumTheme(_:)`. Tokens consumed by descendant views resolve through the active theme; tokens not overridden inherit Spectrum's defaults.

```swift
let brand = Theme(
    name: "MyBrand",
    base: .light,
    overrides: ThemeOverrides()
        .colorOverride(id: "blue-500", with: SpectrumColor(
            lightHex: 0xFF1976D2, darkHex: 0xFF42A5F5))
)
ContentView().spectrumTheme(brand)
```

## Accessibility

- **Dynamic Type (iOS):** typography tokens carry a `Font.TextStyle` anchor so `Text` rendered with `.spectrumFont(_:)` scales with the user's preferred text size.
- **Reduce Motion:** every motion token is a `SpectrumDuration` with both a `base` and a `reduced` variant. The `Animation.spectrum(_:reduceMotion:)` helper picks the right one. In a SwiftUI view, read `\.accessibilityReduceMotion` from the environment and pass it in.

## Refreshing tokens from upstream

Token values come from a checked-in JSON snapshot at `Tools/SpectrumTokensSnapshot/` pinned to a specific commit of `adobe/spectrum-design-data`. To track a new Spectrum release, follow the steps in `Tools/SpectrumTokensSnapshot/README.md` and re-run:

```bash
swift package generate-tokens --allow-writing-to-package-directory
```

The generator is idempotent — running it twice on the same input produces zero diff.
