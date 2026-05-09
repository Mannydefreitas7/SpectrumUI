# Quickstart: Foundations Token System (v0.2.0)

**Feature**: 002-foundations-tokens
**Date**: 2026-05-09

## Prerequisites

- macOS 14+ with Xcode 15+ (provides Swift 5.9 + iOS 17 SDK + Simulator)

## Build and Test the Library

```bash
git clone https://github.com/Mannydefreitas7/SpectrumUI.git
cd SpectrumUI
swift test
```

All ten test targets pass — five product-level tests inherited from v0.1.0 plus the new
suites in `SpectrumUIFoundationsTests` (color-scheme adaptation, theme override,
reduce-motion, generator idempotency, traceability, and per-category snapshot tests).

## Regenerate Tokens (Maintainer)

```bash
swift package generate-tokens
```

Runs the in-tree `GenerateTokens` SPM command plugin. Reads
`Tools/SpectrumTokensSnapshot/spectrum-tokens.json` and writes eight files under
`Sources/SpectrumUIFoundations/Tokens/`. After it runs, `git diff` shows exactly which
tokens changed (zero diff if the snapshot hasn't changed since the last generation).

To refresh the snapshot itself from upstream:

1. See the current pinned commit SHA in `Tools/SpectrumTokensSnapshot/README.md`.
2. Pick a newer commit on `github.com/adobe/spectrum-tokens`.
3. Replace `spectrum-tokens.json` with the corresponding JSON from that commit.
4. Update the SHA in `Tools/SpectrumTokensSnapshot/README.md`.
5. Run `swift package generate-tokens`.
6. Run `swift test` — generator-idempotency, traceability, and snapshot tests will
   verify the refresh.
7. Open a PR with both the snapshot bump and the regenerated `Tokens/*.swift` files.

## Use Tokens in a Consumer App

In your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Mannydefreitas7/SpectrumUI.git", from: "0.2.0")
],
targets: [
    .target(
        name: "MyApp",
        dependencies: [
            .product(name: "SpectrumUIFoundations", package: "SpectrumUI"),
        ]
    )
]
```

In your SwiftUI code:

```swift
import SwiftUI
import SpectrumUIFoundations

struct ContentView: View {
    var body: some View {
        VStack(spacing: Spectrum.spacing.s200) {
            Text("Hello, Spectrum")
                .spectrumFont(Spectrum.typography.headingL)
                .foregroundStyle(Spectrum.color.text.body)
            Text("Adaptive to light and dark.")
                .spectrumFont(Spectrum.typography.bodyM)
                .foregroundStyle(Spectrum.color.text.muted)
        }
        .padding(Spectrum.spacing.s400)
        .background(Spectrum.color.background.primary,
                    in: .rect(cornerRadius: Spectrum.radius.s200))
    }
}
```

Toggle between light and dark in the Xcode preview canvas; the colors switch
automatically — Spectrum's published values for each scheme are used.

## Override a Token for Your Brand

```swift
let myBrand = Theme(
    name: "MyBrand",
    base: .light,
    overrides: ThemeOverrides.empty
        .setting(\.accent.s500, to: SpectrumColor(lightHex: 0xFF1976D2,
                                                  darkHex:  0xFF42A5F5))
)

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .spectrumTheme(myBrand)
        }
    }
}
```

Every descendant view that consumes `Spectrum.color.accent.s500` now picks up your blue.
Every other token continues to display its Spectrum default for the active scheme.

## Verify Reduce-Motion Behavior

Enable Reduce Motion in System Settings (macOS) or Settings → Accessibility → Motion
(iOS). Animations driven via `.spectrumAnimation(Spectrum.motion.transitionMedium)` will
shorten or skip per Spectrum's reduce-motion guidance, with no consumer-side branching.

## What's NOT Yet Available

v0.2.0 ships **only** Foundations — no atoms, molecules, or icons. Importing the four
sister products still gives you the v0.1.0 marker namespaces. Real atoms (Button,
Checkbox, etc.) arrive in v0.3.0+.
