# Package Contract: SpectrumUI

**Feature**: 001-spm-package-skeleton
**Date**: 2026-05-09

The "external interface" of an SPM package is its public **product list** and the
documented dependency rules consumers must respect. This document is that contract for
the SpectrumUI package skeleton. Any change to the items below is a breaking change and
requires the constitution's MAJOR version bump rules.

## 1. Public Products

The following products are exposed by the package and are stable consumption surfaces.

| Product Name | Atomic Role | Stable? | Direct Dependencies (Internal) |
|--------------|-------------|---------|-------------------------------|
| `SpectrumUIFoundations` | Tokens, theme primitives, shared utilities | Yes | _(none)_ |
| `SpectrumUIIcons` | Icon assets, SF Symbol bridging | Yes | `SpectrumUIFoundations` |
| `SpectrumUIAtoms` | Primitive components | Yes | `SpectrumUIFoundations` |
| `SpectrumUIMolecules` | Composed components | Yes | `SpectrumUIFoundations`, `SpectrumUIIcons`, `SpectrumUIAtoms` |
| `SpectrumUI` (umbrella) | Convenience re-export of all atomic products | Yes | All of the above |

**Stability guarantee**: The product names and their atomic roles MUST NOT change
without a MAJOR version bump and a documented migration path. Adding a new product
(e.g., `SpectrumUIOrganisms`) is a MINOR change.

## 2. Consumer Dependency Declaration

Consumers add SpectrumUI to their `Package.swift` like this:

```swift
dependencies: [
    .package(url: "https://github.com/<owner>/SpectrumUI.git", from: "0.1.0")
],
targets: [
    .target(
        name: "MyApp",
        dependencies: [
            // Pick exactly the products you need:
            .product(name: "SpectrumUIFoundations", package: "SpectrumUI"),
            // Or the umbrella for everything:
            // .product(name: "SpectrumUI", package: "SpectrumUI"),
        ]
    )
]
```

**Contract**:

- Consumers MAY depend on any subset of the atomic products.
- Consumers MAY depend on the umbrella `SpectrumUI` instead of (or alongside) any
  atomic product.
- Consumers MUST NOT depend on internal target names that are not exposed as products;
  there are none in the public contract beyond the table in §1.

## 3. Platform Requirements

| Platform | Minimum |
|----------|---------|
| macOS | 14.0 |
| iOS | 17.0 |

The package declares **no other platforms**. Attempting to consume SpectrumUI on tvOS,
watchOS, visionOS, Linux, or Windows MUST fail at the manifest evaluation stage with a
clear platform-mismatch error.

## 4. Swift Tooling Requirements

| Requirement | Version |
|-------------|---------|
| swift-tools-version | 5.9 |
| Xcode (for iOS build path) | 15.0 or later |

A consumer's host package MUST declare `swift-tools-version: 5.9` or later. SpectrumUI
will not compile under Swift 5.8.

## 5. Layering Contract

These rules govern how a consumer's own code may consume SpectrumUI products.

- Consumers MAY freely import any subset of products in any combination.
- Consumers SHOULD prefer importing the lowest-layer product that satisfies their needs
  (e.g., a token-only consumer should import `SpectrumUIFoundations`, not the umbrella).
- The umbrella's transitive dependencies are an implementation detail; consumers MUST NOT
  rely on importing the umbrella to indirectly access symbols from a future, not-yet-
  released product.

## 6. Test Contract (CI)

The package guarantees on the default branch:

- `swift test` from the package root succeeds on macOS 14+ with Xcode 15+ installed.
- `xcodebuild test -scheme SpectrumUI-Package -destination 'platform=iOS Simulator'`
  succeeds against an iOS 17+ simulator runtime.
- Both succeed in CI on every push and pull request.

These contracts are validated by `.github/workflows/ci.yml`.

## 7. Documentation Contract

Each product ships with a `Documentation.docc` catalog. The catalog is consumable by
`swift package generate-documentation` and by Xcode's DocC build. The skeleton baseline
provides only seed content; component features will populate it.

## 8. Versioning Contract

The package follows semantic versioning per the constitution's Governance section:

- **MAJOR**: Removing a product, renaming a product, narrowing platform support,
  raising minimum Swift tools version, or any non-additive public-API change in a
  shipped component.
- **MINOR**: Adding a product (e.g., `SpectrumUIOrganisms`), adding a new public
  component, adding optional initializers/modifiers, expanding platform support.
- **PATCH**: Bug fixes, Spectrum-spec catch-up patches that don't change API,
  documentation improvements, internal refactors with no public-API impact.

Pre-1.0.0 (`0.x.y`), MINOR bumps may include breaking changes per common Swift
ecosystem convention; the public contract still applies but is in flux until 1.0.0
ships with the first set of stable components.
