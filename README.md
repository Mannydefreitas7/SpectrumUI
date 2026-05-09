# SpectrumUI

A SwiftUI port of the [Adobe Spectrum Design System](https://spectrum.adobe.com/) — tokens, foundations, and components — for macOS and iOS.

> **Status**: Skeleton. The package builds and tests green, but ships only marker namespaces. Tokens, icons, atoms, and molecules will land in subsequent releases.

## Supported Platforms

| Platform | Minimum |
|----------|---------|
| macOS    | 14.0    |
| iOS      | 17.0    |

`tvOS`, `watchOS`, `visionOS`, Linux, and Windows are out of scope.

## Products

SpectrumUI follows atomic-design layering. Each layer is published as a standalone Swift Package product so consumers can import only what they need.

| Product | Atomic role | Description |
|---------|-------------|-------------|
| `SpectrumUIFoundations` | Foundations | Design tokens (color, spacing, typography, motion, elevation, radius), theme primitives, shared utilities. |
| `SpectrumUIIcons` | Icons | Spectrum's icon set + SF Symbol bridging. |
| `SpectrumUIAtoms` | Atoms | Primitive components (Button, Checkbox, TextField, Badge, …). |
| `SpectrumUIMolecules` | Molecules | Composed components (SearchField, Card, Toast, …). |
| `SpectrumUI` | Umbrella | Re-exports every atomic product. Convenience entry point. |

## Layering Rules

Dependencies between SpectrumUI products flow **upward only**. A higher layer may depend on lower layers; a lower layer may **never** depend on a higher one.

| From | To (allowed) |
|------|--------------|
| `Foundations` | _(none — it's the base)_ |
| `Icons` | `Foundations` |
| `Atoms` | `Foundations` |
| `Molecules` | `Foundations`, `Icons`, `Atoms` |
| `SpectrumUI` (umbrella) | All of the above |

❌ **Forbidden direction**: `Foundations` may not import `Atoms`. `Atoms` may not import `Molecules`. The package manifest (`Package.swift`) makes these dependencies impossible to express; the build fails with `no such module …` if you try.

When adding a new component, choose the lowest layer that can express it without violating the rule. (Hint: a `SearchField` is a *composition* — it belongs in `Molecules`. A `Button` is a primitive — it belongs in `Atoms`.)

## Quickstart

### Use SpectrumUI in your project

In your own `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Mannydefreitas7/SpectrumUI.git", from: "0.1.0")
],
targets: [
    .target(
        name: "MyApp",
        dependencies: [
            // Pick what you need:
            .product(name: "SpectrumUIFoundations", package: "SpectrumUI"),
            // …or grab everything via the umbrella:
            // .product(name: "SpectrumUI", package: "SpectrumUI"),
        ]
    )
]
```

```swift
import SpectrumUIFoundations
// …or `import SpectrumUI` for the full library.
```

### Build and test the package itself

```bash
git clone https://github.com/Mannydefreitas7/SpectrumUI.git
cd SpectrumUI
swift test
```

Five test targets, all passing, in well under two minutes on a modern Mac.

For the iOS-side check (mirrors CI):

```bash
xcodebuild test \
  -scheme SpectrumUI-Package \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest'
```

## Constitution

This project is governed by a constitution: see [`.specify/memory/constitution.md`](.specify/memory/constitution.md). It defines six non-negotiable principles — Spectrum fidelity, experience parity, token-first architecture, SwiftUI-native API, macOS+iOS parity, and accessibility/documentation/test discipline — plus the platform standards and amendment process. Read it before contributing.

## License

Apache License 2.0. See [LICENSE](LICENSE). This matches Adobe Spectrum's own licensing and includes a patent grant.

