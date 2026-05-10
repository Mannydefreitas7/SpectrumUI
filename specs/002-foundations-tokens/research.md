# Phase 0 Research: Foundations Token System

**Feature**: 002-foundations-tokens
**Date**: 2026-05-09

The spec deliberately deferred several technical choices to planning. This document
captures each decision, the rationale, and the alternatives evaluated. Every entry below
is load-bearing — implementation tasks reference these IDs.

## R-001 — Generator runtime: SPM Command Plugin

**Decision**: Implement the token generator as a Swift Package Manager **command
plugin** under `Plugins/GenerateTokens/`. Maintainers run it via:

```bash
swift package generate-tokens
```

**Rationale**:

- Runs **on demand only**. Does not slow down `swift build` or `swift test` for consumers
  or contributors.
- Single Swift toolchain — no JavaScript, Python, or shell dependency.
- Standard SwiftPM pattern (e.g., `swift-format`, `swift-docc-plugin`). Familiar to
  Swift developers.
- Integrates with Xcode 15+ via the command plugin menu, so contributors who prefer the
  IDE can run it without leaving Xcode.

**Alternatives considered**:

- **SwiftPM Build Tool Plugin** — would run during every `swift build`. Rejected: it
  would force consumers to pay generator cost on every build of Foundations even though
  generated output is checked in, and would couple generator success to the build
  pipeline (a parser bug breaks the whole library, not just regeneration).
- **Standalone executable target** (`.executableTarget`) inside the package — works,
  but adds a product to the package graph, and consumers using the umbrella `SpectrumUI`
  product would see it in their build output. Plugins are invisible to consumers.
- **External Node/JS script** — Spectrum's tokens already come from a `npm` ecosystem,
  so this is tempting. Rejected: introduces a Node toolchain requirement for any
  contributor who wants to refresh tokens. Violates the "single Swift stack" simplicity.

**Consequences**:

- The plugin needs **package access** declared on its target (`permissions`) so it can
  write to `Sources/SpectrumUIFoundations/Tokens/`.
- The first-time runner sees a permission prompt from SwiftPM/Xcode. This is one-shot
  and standard for command plugins.

## R-002 — Color token type: `SpectrumColor` value type with `ShapeStyle` conformance

**Decision**: Define a public `struct SpectrumColor` that conforms to SwiftUI's
`ShapeStyle` and resolves at view-render time using the active `ColorScheme` and the
active `Theme` from `Environment`.

```swift
public struct SpectrumColor: ShapeStyle {
    let lightHex: UInt32      // e.g. 0xFF0066CC
    let darkHex: UInt32
    public func resolve(in env: EnvironmentValues) -> some ShapeStyle { … }
}
```

**Rationale**:

- `ShapeStyle` is the SwiftUI-native abstraction for "things you apply via
  `.foregroundStyle(…)`, `.fill(…)`, `.background(…)`". Conforming to it gives
  `SpectrumColor` first-class status — consumers use it exactly like `Color.red` or
  `.tint`.
- Light/dark resolution happens at the SwiftUI layer at *render* time. The values
  themselves (light hex, dark hex) are stored once.
- Themes can override a `SpectrumColor` by providing a different value for the same
  identifier — the resolution chain reads `EnvironmentValues.spectrumTheme` and falls
  back to the built-in default when no override exists.

**Alternatives considered**:

- **Plain `Color` per scheme** (e.g., `Color { scheme in scheme == .dark ? darkC :
  lightC }`) — SwiftUI `Color` does not have a public scheme-aware initializer in
  iOS/macOS 17/14 SDKs. The closest is wrapping `UIColor`/`NSColor` dynamic providers,
  which we'd then have to expose; that pollutes the public surface with platform
  primitives.
- **Asset catalog (`.xcassets`)** with light/dark color variants — works, but the
  generator would have to write Asset Catalog JSON and we'd lose the "everything in
  Swift source" property. Asset Catalogs also don't compose well with the override
  mechanism.
- **Using `Color` directly** with a pre-baked single value — loses per-scheme
  adaptation entirely.

**Consequence**: `SpectrumColor` is a `ShapeStyle`, not a `Color`. Consumers that
**need** a `Color` (e.g., `.foregroundColor(_:)`, the older API) get a converter:
`spectrumColor.color(in: env)` returning the resolved `Color`.

## R-003 — Token namespace shape: dotted typed paths with `s<N>` for numeric scales

**Decision**: Tokens are exposed under a top-level enum namespace `Spectrum`. Each
category is a sub-namespace; tokens within a category use semantic dot-paths. Numeric
Spectrum scale values use the `s<N>` prefix (Swift identifiers cannot start with a
digit).

```swift
import SpectrumUIFoundations

let bg  = Spectrum.color.accent.s500       // not "500"
let pad = Spectrum.spacing.s200            // 16 pt
let f   = Spectrum.typography.bodyM
```

**Rationale**:

- Matches the consumer-facing access pattern the spec assumed (`Spectrum.color.accent.500`)
  with the minimum-impact rename to satisfy Swift's identifier rules.
- `s` for "scale" is short, lowercase, and prefixes consistently across all numeric
  ladders (color shades, spacing steps, sizing steps, etc.).
- Compile-time safety: typing `accent.acent` errors at the misspelled identifier.
  Typing `accent.s5000` errors because that token doesn't exist.
- Autocomplete is hierarchical — IDE shows categories, then sub-categories, then scale
  values.

**Alternatives considered**:

- **Underscore prefix `_500`** — Swift convention treats leading underscore as
  "private/internal", which would be misleading for public API.
- **Subscript access `accent[500]`** — loses compile-time safety; an unknown shade
  becomes a runtime nil/crash.
- **`shade500`** verbose — repeats "shade" implicitly already understood from context.
- **Flat names like `accentShade500`** — flat names are noisy and lose hierarchy in
  autocomplete.

## R-004 — Override mechanism: theme-level via `Environment`

**Decision**: Customization happens at the **theme** layer. Consumers apply
`.environment(\.spectrumTheme, customTheme)` (or `.spectrumTheme(customTheme)` via a
ViewModifier sugar) at the root of a subtree. A `Theme` is a value type carrying a
sparse override dictionary keyed by token identifier; missing keys fall through to the
Spectrum default for the active scheme.

```swift
let brand = Theme(base: .light, overrides: [
    .color(\.accent.s500): .blue
])

ContentView()
    .spectrumTheme(brand)
```

**Rationale**:

- Constitution Principle II ("Constrained Customization") emphasizes a **bounded** surface.
  Theme-level overrides give consumers exactly one knob — the active theme — and Spectrum
  defaults remain the non-overridden path.
- Single `EnvironmentValue` (`spectrumTheme`) keeps the SwiftUI environment dictionary
  small. Per-token environment keys would explode to hundreds of entries.
- Per-token overrides at a call site (which the spec mentions in passing) are
  *expressible* by constructing a one-key Theme and applying it locally. We don't ship a
  separate per-token modifier in v0.2.0; that's an additive future extension.

**Alternatives considered**:

- **One `EnvironmentValue` per token** (`\.spectrumAccentS500`, etc.) — hundreds of
  keys. Strongly typed but bloats the environment dictionary and slows lookup.
- **Mutating singleton/registry** (e.g., `Spectrum.color.accent.s500 = .blue` at app
  start) — mutable global state, breaks SwiftUI's value semantics, prevents subtree
  scoping.

## R-005 — Typography: `SpectrumFont` wrapper with optional Dynamic Type bridge

**Decision**: Typography tokens produce `SpectrumFont` values. Each `SpectrumFont`
carries a base font (`Font`), optional `Font.TextStyle` (for Dynamic Type-relative
scaling on iOS), and an optional `lineHeight` and `tracking` (kerning) value.

```swift
public struct SpectrumFont {
    let base: Font
    let textStyle: Font.TextStyle?
    let lineHeight: CGFloat?
    let tracking: CGFloat?
}
```

**Rationale**:

- Spectrum typography defines size, weight, leading (line height), and tracking — more
  than `Font` alone exposes.
- `Font.TextStyle` enables Dynamic Type pickup (FR-011). Where a Spectrum text style
  has a clear analog (e.g., body → `.body`, heading 1 → `.title`), the generator emits
  the analog. Where Spectrum's style has no Apple analog, the generator emits raw
  size + a custom-style fallback that scales relative to the closest TextStyle.
- macOS does not honor Dynamic Type; the same `SpectrumFont` value renders at its
  configured size on macOS without error (the `textStyle` simply has no effect).

**Alternatives considered**:

- **Use `Font.TextStyle` directly** — limits us to Apple's 11 styles. Spectrum has
  more.
- **Use raw `Font` only, no TextStyle** — loses Dynamic Type pickup on iOS, violating
  FR-011.
- **Custom `View` that draws text with manual sizing** — works but couples typography
  to a View, breaking the "tokens are values" intuition.

## R-006 — Reduce-motion handling

**Decision**: Motion tokens expose two values — a base `Duration` and a `reduced`
`Duration` (often `0` or near-zero). At the consumer call site, a small helper resolves
which to use:

```swift
let dur = Spectrum.motion.transitionMedium
    .resolve(reduceMotion: env.accessibilityReduceMotion)
```

A `View` extension `.spectrumAnimation(_:)` does the resolution implicitly so the common
path stays terse.

**Rationale**:

- SwiftUI exposes `\.accessibilityReduceMotion` (`Bool`) on `EnvironmentValues`. The
  source of truth.
- Per-token reduced values live alongside the base values in the JSON; the generator
  emits both fields.
- Consumers who want full control can read the base value directly; the convenience
  modifier handles the 90% case.

**Alternatives considered**:

- **Globally zero out motion when reduce-motion is on** — too blunt; some animations
  should be shortened to a fade rather than removed entirely.
- **Each motion token has only one value, app code does the branching** — pushes
  responsibility onto every consumer. Easy to forget; FR-012 would be violated in
  practice.

## R-007 — Fate of v0.1.0 `moduleName` constant

**Decision**: **Remove** the `public static let moduleName = "SpectrumUIFoundations"`
from `SpectrumUIFoundations`. The replacement is the typed token namespace; `moduleName`
served only as a "I imported this" smoke test.

The five test targets that asserted `moduleName` get rewritten to assert real public
symbols (e.g., `_ = Spectrum.spacing.s100` to prove the import resolved).

**Rationale**:

- v0.1.0 is pre-1.0.0; the constitution's versioning section permits breaking changes
  in pre-1.0.0 minor releases.
- Carrying `moduleName` forward perpetuates a placeholder that adds nothing once real
  symbols exist.
- The umbrella product (`SpectrumUI`) and the four sister products keep their
  `moduleName` for v0.2.0 since they don't yet have real tokens. They will lose it in
  the same way as each gets its own real surface.

**Alternatives considered**:

- **Keep `moduleName` as a deprecated symbol** — ships dead code; pre-1.0.0 makes the
  deprecation choreography unnecessary.

## R-008 — JSON snapshot: pin to a specific commit of `adobe/spectrum-tokens`

**Decision**: The generator's input JSON is sourced from
`https://github.com/adobe/spectrum-tokens` and pinned to a specific commit SHA. The
SHA + the source file paths used are recorded in `Tools/SpectrumTokensSnapshot/README.md`
alongside the JSON snapshot. Refreshing the snapshot is a maintainer task documented in
that README and gated by a manifest update + PR.

**Rationale**:

- Reproducibility (FR-003): a specific SHA + a specific JSON-file shape produce a
  specific Swift output.
- Auditability (FR-005, FR-017): every token in the generated source can be traced back
  to a path in the snapshot, and the snapshot itself can be traced back to upstream.
- Refresh is a deliberate ceremony, not an automated nightly job. Spectrum changes are
  not so frequent that automation pays off; manual refresh-and-review is healthier.

**Alternatives considered**:

- **Pull at runtime via a `URLSession`** — turns the generator into a network-dependent
  tool. Reproducibility evaporates. Rejected.
- **Pull at generator-run time, no snapshot file** — same problem.
- **Vendor only the few tokens we need** — defeats the "trace back to upstream"
  invariant.

## R-009 — Snapshot testing dependency

**Decision**: Add `https://github.com/pointfreeco/swift-snapshot-testing` (>= 1.15) as a
**test-only** package dependency. Used by `ColorSchemeAdaptationTests` and the
per-category snapshot suites.

**Rationale**:

- The de-facto standard Swift snapshot-testing library. Stable, low-churn API,
  cross-platform support (macOS + iOS).
- Test-only dependency has zero impact on consumers — it doesn't appear in the library
  product graph.
- Constitution forbids external **runtime** dependencies; dev dependencies are
  permitted. This is a dev dep.

**Alternatives considered**:

- **Hand-roll image-diff via `XCTAttachment`** — reinventing the wheel; loses the
  "automatic record/verify" workflow that snapshot-testing provides.
- **No snapshot tests, only assertions on resolved values** — would skip rendering
  entirely, missing visual regressions like an off-by-one tracking value.

## R-010 — Out-of-scope items intentionally deferred

The following appeared during planning and are **deferred** to later releases:

- **Per-token in-line override modifier** (e.g., `.spectrumColor(\.accent.s500, .blue)`)
  — derivable from theme overrides; convenience sugar can land later without breaking
  changes.
- **Spectrum themes beyond light/dark** (`darkest`, `wireframe`) — explicitly deferred
  by spec FR-018.
- **Custom font bundling** for Spectrum's brand typeface — typography tokens initially
  use system fonts; brand-font support is its own feature.
- **Token preview UI** (e.g., a SwiftUI playground showing every token swatch) — useful
  for designers but not blocking; can ship in a `SpectrumUIPreview` companion target.
- **Type-level proof of upward-only graph** — SC-006 from feature 001 was verified
  manually; converting to an automated test (parsing `Package.swift`) is still optional
  and remains in 001's tasks.md backlog.
