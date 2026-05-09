# Quickstart: SPM Package Skeleton

**Feature**: 001-spm-package-skeleton
**Date**: 2026-05-09

This quickstart describes how a contributor or evaluator validates that the skeleton
works on a fresh clone, and how a consumer integrates it into their own Swift Package.
It is intentionally short — the skeleton's whole purpose is that it works without a
quickstart.

## Prerequisites

- macOS 14 or later
- Xcode 15.0 or later (provides Swift 5.9 + iOS 17 SDK + Simulator)
- Git

## Validate the Skeleton (Contributor)

```bash
git clone https://github.com/<owner>/SpectrumUI.git
cd SpectrumUI
swift test
```

**Expected outcome**: Every product test target compiles and passes. Total runtime is
under two minutes on a modern Mac.

To run the iOS-side check locally (mirrors the CI iOS job):

```bash
xcodebuild test \
  -scheme SpectrumUI-Package \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=17.5'
```

(`SpectrumUI-Package` is the auto-generated scheme SPM creates for the root package.)

## Open in Xcode

```bash
open Package.swift
```

Xcode resolves and opens the package. All five products are visible in the scheme picker.
Each product's test target is runnable individually with `Cmd+U`.

## Build the Documentation

```bash
swift package generate-documentation
```

DocC builds for each product against its `Documentation.docc` seed catalog. No warnings
expected on a clean run.

## Consume the Package (Consumer)

In your own SwiftPM project, add SpectrumUI as a dependency:

```swift
// In your Package.swift
dependencies: [
    .package(url: "https://github.com/<owner>/SpectrumUI.git", from: "0.1.0")
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

```swift
// In your Swift code
import SpectrumUIFoundations

print(SpectrumUIFoundations.moduleName)  // "SpectrumUIFoundations"
```

For the full library, depend on the umbrella product instead:

```swift
.product(name: "SpectrumUI", package: "SpectrumUI")
```

```swift
import SpectrumUI
// Foundations, Icons, Atoms, Molecules symbols are all in scope.
```

## Verify the Layering Rule

To confirm the upward-only constraint is enforced:

```bash
# Try to add a downward import in Sources/SpectrumUIFoundations/SpectrumUIFoundations.swift:
#   import SpectrumUIAtoms
# Save and run:
swift build
```

**Expected**: The build fails with `no such module 'SpectrumUIAtoms'`. Foundations does
not declare Atoms as a target dependency in `Package.swift`, so the import cannot be
resolved. Revert the file to recover.

## What's NOT Yet Available

The skeleton ships with marker namespace stubs, not real components. Consumers can
import the products successfully, but no tokens, no icons, no buttons, no fields exist
yet. Those land in subsequent features (the next will be Foundations / token system).
