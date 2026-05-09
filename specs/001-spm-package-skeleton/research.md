# Phase 0 Research: SPM Package Skeleton

**Feature**: 001-spm-package-skeleton
**Date**: 2026-05-09

The Technical Context in `plan.md` had no `NEEDS CLARIFICATION` markers — every technical
choice was either fixed by the spec or constrained by the constitution. This document
captures the design decisions where multiple reasonable options existed, the choice made,
why, and the alternatives rejected. It is the source of truth for any technical
disagreement that surfaces during implementation.

## R-001 — Encoding the upward-only dependency graph

**Decision**: Encode every product's allowed upward dependencies directly in
`Package.swift` as `target.dependencies`. The manifest itself is the enforcement
mechanism.

**Rationale**:

- SPM resolves and validates the dependency graph at manifest evaluation time. A cycle or
  missing dependency causes `swift package describe` to fail before any code compiles.
- Code review catches manifest changes obviously: a downward dependency (e.g., adding
  Atoms to Foundations' deps list) shows up as a one-line diff in `Package.swift`, easy
  to flag.
- No external linter is needed; the type system's inability to import a non-declared
  module already enforces the runtime side.

**Alternatives considered**:

- **Custom SwiftSyntax linter that parses Package.swift and rejects downward edges.**
  Rejected: adds tooling overhead and a separate failure mode for marginal benefit. The
  manifest is already a single, reviewable file.
- **Separate sub-packages (one Package.swift per layer) with cross-package dependencies.**
  Rejected: multiplies manifests, breaks `swift test` from the root, and complicates the
  consumer story without strengthening the invariant.

## R-002 — Umbrella product re-export strategy

**Decision**: The `SpectrumUI` umbrella product depends on all four atomic products and
exposes them through `@_exported import` statements in
`Sources/SpectrumUI/SpectrumUI.swift`. Consumers who import `SpectrumUI` get every
atomic layer's public API in scope.

**Rationale**:

- `@_exported import` is the standard idiom for umbrella modules in Swift packages
  (Apple's own packages use it).
- Keeps the umbrella as a thin re-export layer with zero behavioral surface — easy to
  reason about and trivially testable.
- Atomic products remain independently importable, so the umbrella doesn't compromise
  Principle II's atomic granularity (Platform & Tooling Standards in the constitution).

**Alternatives considered**:

- **Public typealiases re-exporting individual symbols.** Rejected: requires per-symbol
  maintenance and breaks as soon as components proliferate.
- **Drop the umbrella entirely; force consumers to import each layer.** Rejected: the
  user spec explicitly requested an optional umbrella for low-friction consumption.
- **Make the umbrella the only consumption path.** Rejected: violates the constitution's
  rule that "A top-level SpectrumUI umbrella product MAY re-export the layers for
  convenience but MUST NOT be the only consumption path."

**Caveats** to document in code comments:

- `@_exported import` is technically an underscored attribute. It is widely used and
  considered de facto stable, but the `_` is a reminder that Swift Evolution has not
  formally blessed it. Acceptable risk; the alternative is worse.

## R-003 — CI matrix on macOS and iOS

**Decision**: A single GitHub Actions workflow at `.github/workflows/ci.yml` with one
matrix job. Matrix axes:

- `platform`: `macOS`, `iOS`
- `runner`: `macos-14` (the only modern macOS runner that bundles Xcode 15+, required
  for Swift 5.9 + iOS 17 SDK)

Job steps:

1. Checkout
2. Select Xcode (`sudo xcode-select -s /Applications/Xcode_15.x.app`) — exact version
   pinned to avoid runner-image drift
3. For `macOS`: `swift test`
4. For `iOS`: `xcodebuild test -scheme SpectrumUI-Package -destination 'platform=iOS
   Simulator,name=iPhone 15,OS=17.x'`

**Rationale**:

- Matrix gives one PR check per platform (Principle V parity is visible in PR UI).
- `macos-14` runner has both macOS 14 SDK (for `swift test`) and the iOS 17 simulator
  preinstalled — a single runner handles both axes.
- `xcodebuild test` is the only path to running XCTest in an iOS simulator from CI;
  `swift test` does not target iOS.
- Pinning Xcode avoids the classic "CI green Tuesday, red Wednesday" drift after
  GitHub rotates runner images.

**Alternatives considered**:

- **Two separate workflow files.** Rejected: same logic duplicated; matrix is cleaner.
- **`swift test` for both axes.** Rejected: doesn't actually exercise iOS — `swift test`
  on a Mac runs against the host (macOS) SDK regardless.
- **`fastlane scan`.** Rejected: extra dependency for no benefit at this stage.

## R-004 — DocC catalog stub structure

**Decision**: Each product gets a `Documentation.docc` folder containing exactly one
file: `Documentation.md`. The Markdown file has a single-line heading
(`# ``SpectrumUIFoundations``` for example) so `swift package generate-documentation` (or
Xcode's DocC build) succeeds without warnings on day one.

**Rationale**:

- Empty `.docc` folders are silently ignored by Xcode and produce a vague warning by
  `swift package generate-documentation`. A single seed file stops the warning.
- The seed file becomes the entry point that future component documentation slots into,
  so contributors don't need to debate "where does the top-level overview go?"
- Constitution Principle VI requires DocC-ready public-API comments. Catalog presence is
  the obvious complement.

**Alternatives considered**:

- **No `.docc` folders at all.** Rejected: spec explicitly requires DocC stubs (FR-013).
- **Empty `.docc` folders.** Rejected: DocC build emits warnings that pollute CI logs.

## R-005 — Minimal-but-real XCTest pattern for stub modules

**Decision**: Each test target ships with one test that imports its product and asserts
on a public marker symbol. Example:

```swift
import XCTest
@testable import SpectrumUIFoundations

final class SpectrumUIFoundationsTests: XCTestCase {
    func testProductIsImportable() {
        XCTAssertEqual(SpectrumUIFoundations.moduleName, "SpectrumUIFoundations")
    }
}
```

The `moduleName` (or equivalent) is a `public static let` on the product's marker
namespace stub.

**Rationale**:

- Satisfies Principle VI's "simple unit test" requirement with a real assertion (FR-004).
- Verifies the import path works — catching mis-configured target dependencies early.
- Survives unchanged when real types are added; the marker stays as a sanity check.
- The umbrella test imports `SpectrumUI` and asserts a marker from each re-exported
  product, proving the `@_exported import` chain works end-to-end.

**Alternatives considered**:

- **`XCTAssertTrue(true)` placeholder.** Rejected: not a real assertion; FR-004 forbids.
- **Snapshot tests of stub views.** Rejected: stubs aren't `View`s; pre-emptive snapshot
  infrastructure is out of scope for the skeleton (the snapshot stack lands when first
  components do).

## R-006 — Versioning the skeleton

**Decision**: Initial git tag `v0.1.0` is created **at the close of this feature**, not
during it. The tag itself is out of scope for the skeleton's tasks; this research entry
just locks the policy.

**Rationale**:

- `0.x.y` signals pre-1.0 instability per semver convention. Suitable while only the
  skeleton exists.
- Cutting `1.0.0` requires Foundations + at least Atoms shipped, per the constitution's
  versioning gate.
- The package builds and tests without a tag; tagging is a release ceremony, not a
  dependency.

**Alternatives considered**:

- **Tag `0.0.1` immediately.** Rejected: `0.1.0` better signals "intentional milestone"
  vs. "first commit".
- **Skip tagging until 1.0.0.** Rejected: consumers experimenting with the skeleton
  benefit from a stable reference.

## R-007 — Source stub design (the "marker namespace")

**Decision**: Each product's stub is a `public enum` namespace with a single
`public static let moduleName: String` and a DocC `///` doc comment. Example:

```swift
/// Root namespace for the Foundations layer of SpectrumUI.
///
/// Foundations exposes design tokens (color, spacing, typography, motion, elevation,
/// radius), theme primitives, and shared utilities. It has zero dependencies on other
/// SpectrumUI products and is consumed by every higher layer.
public enum SpectrumUIFoundations {
    /// Stable string identifier for this product. Useful in diagnostics and tests.
    public static let moduleName = "SpectrumUIFoundations"
}
```

**Rationale**:

- `enum` (no cases) is the canonical Swift idiom for a "namespace that cannot be
  instantiated".
- Carries the DocC comment that Principle VI requires from day one.
- Provides a stable public symbol for the test target to reference (R-005).
- Trivial to delete or move when real types replace it.

**Alternatives considered**:

- **Empty file with no symbols.** Rejected: leaves nothing for the test to assert and
  technically still requires a `_ = ()` somewhere to silence the linter once enabled.
- **`struct` namespace.** Rejected: structs can be instantiated; `enum`-no-cases conveys
  intent unambiguously.

## R-008 — Out-of-scope items intentionally deferred

The following were considered and explicitly deferred to later features:

- **`SwiftLint` / `swift-format` configuration** — quality of life, not in spec.
- **Pre-commit hooks (Husky-equivalent for Swift)** — out of scope.
- **Release automation (GitHub Releases, changelog generation)** — separate feature.
- **Adopting Swift Testing (the new `Testing` framework)** — XCTest is the spec choice;
  a future migration is its own spec.
- **`tvOS`/`watchOS`/`visionOS` support** — explicit Assumptions exclusion.
- **Code signing, notarization** — N/A for an SPM-only library.

These appear in the Assumptions section of `spec.md`; this list documents that they were
considered, not just absent.
