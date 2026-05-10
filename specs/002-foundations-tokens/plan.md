# Implementation Plan: Foundations Token System

**Branch**: `002-foundations-tokens` | **Date**: 2026-05-09 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/002-foundations-tokens/spec.md`

## Summary

Replace the v0.1.0 marker-namespace stub in `SpectrumUIFoundations` with a real,
generator-driven token system. Tokens for all eight categories (color, spacing,
typography, motion, elevation, radius, opacity, sizing) are produced from a checked-in
snapshot of Adobe's published Spectrum JSON via an in-tree Swift Package Manager command
plugin. Tokens are exposed through a typed Swift hierarchy, render adaptively for
SwiftUI's `light`/`dark` color schemes, and can be overridden per-subtree via a SwiftUI
`Environment`-based theme value. Snapshot tests cover at least one token per category in
both color schemes on both platforms.

## Technical Context

**Language/Version**: Swift 5.9+ (the package's declared `swift-tools-version`).
**Primary Dependencies**: SwiftUI (built-in), Foundation (built-in). One **dev-only**
external test dependency: `pointfreeco/swift-snapshot-testing` (≥ 1.15) — added under
the test targets only, not the library targets, so consumers do not pull it in.
**Storage**: N/A. Token values live in generated Swift source; the Spectrum JSON snapshot
lives as a checked-in file.
**Testing**: XCTest plus snapshot tests via the snapshot-testing package. Generator
idempotency and traceability are covered by ordinary XCTest cases.
**Target Platform**: macOS 14+, iOS 17+ (inherited from v0.1.0 `Package.swift` platforms).
**Project Type**: Swift library (additions to existing multi-product SPM package).
**Performance Goals**: Token resolution at view-render time MUST not introduce measurable
overhead (target: <0.1 ms per token lookup on a 2024-era Mac/iPhone). Generator runs in
under 5 seconds on the checked-in snapshot.
**Constraints**: Public API surface is SwiftUI-native (no UIKit/AppKit types); Constitution
Principles I (Spectrum fidelity) and III (token-first) impose hard rules — token values
MUST come from the generator, never be hand-typed.
**Scale/Scope**: ~hundreds of tokens across 8 categories (Spectrum's published set).
Generator output is committed; library load time and build time scale linearly with token
count and remain well within Swift's normal range.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Spectrum Fidelity (NON-NEGOTIABLE) | ✅ Pass | Generator-from-JSON makes fidelity automatic. Hand-edited tokens are forbidden by the generator's idempotency check. |
| II. Experience Parity & Constrained Customization | ✅ Pass | Customization is a theme-level override surface (consumers supply a `Theme` value via `Environment`); per-token override is a derived case. Spectrum defaults remain the recommended path. Motion tokens respect reduce-motion (FR-012); typography respects Dynamic Type (FR-011). |
| III. Token-First Architecture | ✅ Pass | This feature **is** the typed token system. No raw literals leak into Foundations source — even the per-platform color values are JSON-sourced. |
| IV. SwiftUI-Native API | ✅ Pass | Public surface uses `Color`, `CGFloat`, `Font`/`SpectrumFont`, `Duration`/`TimeInterval`, and `EnvironmentValues`. UIKit/AppKit are used only inside opaque implementations of `SpectrumColor` (dynamic providers) and never appear in public types. |
| V. macOS + iOS Parity | ✅ Pass | Single shared implementation per token. CI matrix already verifies both platforms; new snapshot tests run on both. |
| VI. Accessibility, Documentation & Test Discipline | ✅ Pass | Each generated token has a DocC `///` comment with description + JSON source path (FR-014). Snapshot tests cover both color schemes on both platforms (FR-015). Dynamic Type (FR-011) and reduce-motion (FR-012) are honored. |

**Platform & Tooling Standards**:

- ✅ Swift 5.9+, SPM, macOS 14+/iOS 17+, atomic SPM module structure unchanged. Tokens live in the existing `SpectrumUIFoundations` product.
- ✅ Token source IS the published Spectrum JSON snapshot, exactly as the standards section specifies.

**Development Workflow & Quality Gates**:

- ✅ CI runs unchanged. Snapshot tests added to the existing matrix.
- ✅ Versioning: this is a `0.1.0 → 0.2.0` MINOR bump. Pre-1.0.0 conventions permit breaking the v0.1.0 `moduleName` constant; that's documented in research R-007.

**Result**: PASS. No constitution violations.

## Project Structure

### Documentation (this feature)

```text
specs/002-foundations-tokens/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/
│   └── foundations-public-api.md
├── checklists/
│   └── requirements.md
├── spec.md
└── tasks.md             # /speckit-tasks output (later)
```

### Source Code (repository root)

```text
Package.swift                                  # add the snapshot-testing test dep + the
                                               # GenerateTokens command plugin

Sources/SpectrumUIFoundations/
├── SpectrumUIFoundations.swift                # entry namespace (replaces v0.1.0 stub)
├── Theme/
│   ├── Theme.swift                            # public struct Theme
│   ├── ThemeEnvironmentKey.swift              # EnvironmentValues+spectrumTheme
│   └── BuiltInThemes.swift                    # .light, .dark
├── Color/
│   └── SpectrumColor.swift                    # public struct, ShapeStyle conforming
├── Tokens/                                    # generated, do not edit by hand
│   ├── ColorTokens.swift
│   ├── SpacingTokens.swift
│   ├── TypographyTokens.swift
│   ├── MotionTokens.swift
│   ├── ElevationTokens.swift
│   ├── RadiusTokens.swift
│   ├── OpacityTokens.swift
│   └── SizingTokens.swift
└── Documentation.docc/
    └── Documentation.md                       # already exists; extend with token guides

Plugins/
└── GenerateTokens/                            # SPM command plugin
    └── GenerateTokens.swift

Tools/
├── SpectrumTokensSnapshot/
│   └── spectrum-tokens.json                   # checked-in JSON snapshot from upstream
└── README.md                                  # how to refresh the snapshot

Tests/SpectrumUIFoundationsTests/
├── SpectrumUIFoundationsTests.swift           # existing — adjust after moduleName drop
├── ColorSchemeAdaptationTests.swift
├── ThemeOverrideTests.swift
├── ReduceMotionTests.swift
├── GeneratorIdempotencyTests.swift
├── TraceabilityTests.swift
└── __Snapshots__/                             # snapshot-testing artifacts
```

**Structure Decision**: Single-package additions to the existing multi-product SPM
layout. The token system lives entirely inside `SpectrumUIFoundations`; the generator is
a sibling plugin in `Plugins/GenerateTokens/`; the JSON snapshot lives outside `Sources/`
under `Tools/` so it isn't compiled into the library. Generated `Tokens/*.swift` files
ARE compiled and ARE committed (FR-004) — they sit inside `Sources/` but carry a "do not
edit" header banner that the generator regenerates on each run.

## Complexity Tracking

> No constitution violations. No entries.

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| _none_    | _none_     | _none_                              |

## Post-Design Re-Check

Re-evaluated after Phase 1 produced `research.md`, `data-model.md`,
`contracts/foundations-public-api.md`, and `quickstart.md`. The Phase 1 artifacts
introduce no implementation choices that would violate any principle — the chosen public
surface (Theme, SpectrumColor, typed token namespaces) keeps Constitution Principles III
(token-first) and IV (SwiftUI-native) intact, and adds explicit accessibility plumbing
that strengthens VI. Constitution Check continues to PASS.
