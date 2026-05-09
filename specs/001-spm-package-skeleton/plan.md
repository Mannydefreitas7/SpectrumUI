# Implementation Plan: SPM Package Skeleton

**Branch**: `001-spm-package-skeleton` | **Date**: 2026-05-09 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/001-spm-package-skeleton/spec.md`

## Summary

Establish the SpectrumUI Swift Package layout that exposes five atomically-scoped library
products — `SpectrumUIFoundations`, `SpectrumUIIcons`, `SpectrumUIAtoms`,
`SpectrumUIMolecules`, plus an umbrella `SpectrumUI` — each with its own source target,
test target, and DocC catalog stub. Wire the inter-product dependency graph so it flows
strictly upward (Foundations → Icons/Atoms → Molecules → Umbrella) and add a single
GitHub Actions workflow that builds and tests on macOS 14+ and iOS 17+. Ship a top-level
README that explains the layering and links the constitution. The repository must produce
a green `swift test` on a fresh clone with no manual setup.

## Technical Context

**Language/Version**: Swift 5.9 (swift-tools-version: 5.9)
**Primary Dependencies**: Swift Package Manager (built-in), XCTest (built-in). No
third-party runtime or test dependencies.
**Storage**: N/A
**Testing**: XCTest, one test target per product, ≥1 real-assertion test each.
**Target Platform**: macOS 14+, iOS 17+ (declared in `Package.swift` `platforms`).
**Project Type**: Swift library (multi-product SPM package)
**Performance Goals**: `swift test` from clean clone completes in under 2 minutes on a
typical developer machine (SC-001). CI matrix completes in under 15 minutes (SC-004).
**Constraints**: Apple platforms only; upward-only dependency graph between atomic
products; zero external runtime dependencies; no platform other than macOS/iOS in
`Package.swift` `platforms`.
**Scale/Scope**: 5 library products, 5 source targets, 5 test targets, 1 CI workflow file,
1 README, 5 DocC catalog stubs.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

Evaluating each principle from `.specify/memory/constitution.md` against the planned
skeleton.

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Spectrum Fidelity (NON-NEGOTIABLE) | ✅ N/A | The skeleton ships no components or tokens; principle takes effect when component features land. |
| II. Experience Parity & Constrained Customization | ✅ N/A | No interactive surface yet. |
| III. Token-First Architecture | ✅ N/A | No tokens yet; the Foundations stub is a marker namespace, not a hard-coded literal. |
| IV. SwiftUI-Native API | ✅ Pass | Public stubs are inert (empty namespaces). They expose no UIKit/AppKit types and no CSS-isms. |
| V. macOS + iOS Parity | ✅ Pass | Single shared implementation per product; `Package.swift` declares both platforms; CI matrix builds both. |
| VI. Accessibility, Documentation & Test Discipline | ✅ Pass | Each product has ≥1 unit test, a DocC catalog stub, and the README documents layering. Stubs carry DocC `///` comments per Principle VI requirement #4. Accessibility validation (item 3) doesn't apply until components ship. |

**Platform & Tooling Standards**:

- ✅ Swift 5.9+, SPM, macOS 14+, iOS 17+, atomic SPM module structure with upward-only
  dependencies, no umbrella-only consumption path, no circular deps.

**Development Workflow & Quality Gates**:

- ✅ CI builds + tests on both platforms; semantic versioning starts at 0.1.0 for the
  skeleton (pre-stable until Foundations ships); breaking-change rule documented in
  README for future PRs.

**Result**: PASS. No constitution violations. No entries needed in Complexity Tracking.

**Post-Design Re-Check (after Phase 1)**: Re-evaluated after generating `research.md`,
`data-model.md`, `contracts/package-contract.md`, and `quickstart.md`. The Phase 1
artifacts introduced no implementation choices that would violate any principle — they
are purely documentation. Constitution Check continues to PASS.

## Project Structure

### Documentation (this feature)

```text
specs/001-spm-package-skeleton/
├── plan.md              # This file (/speckit-plan command output)
├── research.md          # Phase 0 output (/speckit-plan command)
├── data-model.md        # Phase 1 output (/speckit-plan command)
├── quickstart.md        # Phase 1 output (/speckit-plan command)
├── contracts/           # Phase 1 output (/speckit-plan command)
│   └── package-contract.md
├── checklists/
│   └── requirements.md  # /speckit-specify quality checklist
├── spec.md              # /speckit-specify output
└── tasks.md             # Phase 2 output (/speckit-tasks command - NOT created by /speckit-plan)
```

### Source Code (repository root)

```text
Package.swift                                  # multi-product manifest, swift-tools-version 5.9
README.md                                      # platforms, products, layering rules, constitution link

Sources/
├── SpectrumUIFoundations/
│   ├── SpectrumUIFoundations.swift            # public empty namespace stub with DocC ///
│   └── Documentation.docc/                    # empty DocC catalog
├── SpectrumUIIcons/
│   ├── SpectrumUIIcons.swift                  # depends on Foundations
│   └── Documentation.docc/
├── SpectrumUIAtoms/
│   ├── SpectrumUIAtoms.swift                  # depends on Foundations
│   └── Documentation.docc/
├── SpectrumUIMolecules/
│   ├── SpectrumUIMolecules.swift              # depends on Foundations + Icons + Atoms
│   └── Documentation.docc/
└── SpectrumUI/
    ├── SpectrumUI.swift                       # umbrella; @_exported import of all atomic products
    └── Documentation.docc/

Tests/
├── SpectrumUIFoundationsTests/
│   └── SpectrumUIFoundationsTests.swift       # ≥1 real-assertion XCTest
├── SpectrumUIIconsTests/
│   └── SpectrumUIIconsTests.swift
├── SpectrumUIAtomsTests/
│   └── SpectrumUIAtomsTests.swift
├── SpectrumUIMoleculesTests/
│   └── SpectrumUIMoleculesTests.swift
└── SpectrumUITests/
    └── SpectrumUITests.swift

.github/
└── workflows/
    └── ci.yml                                 # matrix: macOS + iOS, build + test
```

**Structure Decision**: Multi-product SPM package. One library product per atomic-design
layer plus one umbrella, each with a paired test target. The directory layout mirrors
the product names exactly so `swift package` resolves source paths by convention without
any per-target `path:` overrides. The dependency graph is encoded once in
`Package.swift` and is the single source of truth for layering rules — making any
violation visible in a single file diff during code review.

## Complexity Tracking

> No constitution violations. No entries.

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| _none_    | _none_     | _none_                              |
