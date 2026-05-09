# Feature Specification: Foundations Token System

**Feature Branch**: `002-foundations-tokens`
**Created**: 2026-05-09
**Status**: Draft
**Input**: User description: "SpectrumUIFoundations: design token system covering color, spacing, typography, motion, elevation, radius, opacity, and sizing. Tokens generated from Adobe Spectrum's published JSON via a checked-in generator. Light + dark themes. SwiftUI EnvironmentValues integration for theme propagation."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Apply Spectrum Tokens in a SwiftUI View, Adaptive to Color Scheme (Priority: P1)

A SwiftUI developer adds SpectrumUIFoundations to their app and uses Spectrum's design
tokens to style a view — colors, spacing, typography, motion, elevation, radius, opacity,
and sizing. Their view automatically renders correctly in both light and dark mode without
any extra work. Switching the system color scheme updates the rendering at runtime.

**Why this priority**: This is the headline value of the entire Foundations feature. If
consumers cannot apply tokens to views and get correct, theme-aware rendering, nothing
else matters — the generator, type safety, and customization surfaces are all in service
of this experience.

**Independent Test**: Build a tiny SwiftUI sample that imports `SpectrumUIFoundations`,
references at least one token from each of the eight categories, and renders correctly
on macOS and iOS in both light and dark mode.

**Acceptance Scenarios**:

1. **Given** a SwiftUI view that consumes a color token, **When** the system is in light
   mode, **Then** the rendered color matches the Spectrum spec's light value for that
   token; **When** the system is in dark mode, **Then** the rendered color matches the
   Spectrum spec's dark value.
2. **Given** a SwiftUI view that consumes a spacing, radius, or sizing token, **When**
   it renders, **Then** the geometry matches the Spectrum spec's pixel values for that
   token.
3. **Given** a SwiftUI view with a typography token applied to a `Text`, **When** the
   user changes Dynamic Type size, **Then** the rendered text scales appropriately.
4. **Given** a SwiftUI view with a motion token driving an animation, **When** the user
   has enabled "reduce motion" in system accessibility settings, **Then** the animation
   respects that preference (shortened, replaced with a fade, or skipped per Spectrum's
   reduce-motion guidance).

---

### User Story 2 - Customize Themes for Brand Adaptation (Priority: P2)

A consumer wants their app to use Spectrum's design language but with brand-specific
overrides — for example, replacing Spectrum's accent color with their company's blue, or
swapping the body font for a custom typeface. They override individual tokens at the root
of their view hierarchy, and every descendant view that consumes that token picks up the
override automatically. Tokens they do not override continue to use the Spectrum default.

**Why this priority**: Constitution Principle II ("Constrained Customization") promises a
reasonable customization surface. Without this story, every consumer has to fork the
library or hand-roll their own tokens — defeating the point of using SpectrumUI at all.
Lower priority than US1 because the library is still useful (with default Spectrum
values) without it; brand adaptation is the second-most-common need.

**Independent Test**: Build a sample app that overrides exactly one token (e.g.,
`accent.500`) at the root view, and verify that (a) every component using that token
picks up the override, (b) every other token retains its Spectrum default, and (c)
removing the override returns to the Spectrum default.

**Acceptance Scenarios**:

1. **Given** a consumer overrides a single color token at the root of their view tree,
   **When** descendant views consume that token, **Then** they receive the override
   value rather than the Spectrum default.
2. **Given** a consumer overrides a token, **When** descendant views consume *other*
   tokens, **Then** those other tokens retain their Spectrum default values.
3. **Given** a consumer applies an override at one subtree, **When** a sibling subtree
   consumes the same token, **Then** the sibling sees the unmodified Spectrum default.

---

### User Story 3 - Regenerate Tokens from Upstream Spectrum (Priority: P2)

A SpectrumUI maintainer wants to update tokens to match a new Spectrum release. They run
a single documented command, and the generator pulls the latest Spectrum JSON, transforms
it into Swift source, and writes the result over the existing generated files. The
output diff in git makes it obvious which tokens changed.

**Why this priority**: Without a generator, tokens drift from upstream Spectrum and
maintainers spend their time hand-syncing values. This violates Constitution Principle I
("Spectrum Fidelity") in practice. Same priority as customization because both are
sustainability concerns — the library survives long-term only if both work.

**Independent Test**: Delete every generated token file, run the regenerate command, and
verify the working tree returns to a state where all tests pass and no token files differ
from before deletion.

**Acceptance Scenarios**:

1. **Given** a checked-in snapshot of Spectrum's token JSON, **When** the maintainer runs
   the regenerate command, **Then** the generator produces Swift source files matching
   the snapshot's contents.
2. **Given** the generator is run twice in a row with the same input, **When** the second
   run completes, **Then** the working tree shows zero diff — generation is idempotent.
3. **Given** a new version of Spectrum's JSON snapshot is checked in, **When** the
   maintainer runs the regenerate command, **Then** the diff in the generated Swift
   sources reflects exactly the changes between the two JSON versions.
4. **Given** a token in the generated source, **When** a contributor reads the source,
   **Then** they can see (via a doc comment) the exact path in the source JSON that
   produced the token value.

---

### User Story 4 - Discover Tokens via Type-Safe APIs (Priority: P3)

A SwiftUI developer typing token references in Xcode gets accurate autocompletion at
every level of the token hierarchy. Typos produce compile errors at the misspelled
identifier; they never silently return a wrong value. Each token's DocC comment, when
hovered, shows its Spectrum source and intended usage.

**Why this priority**: Quality-of-life improvement. The library is functional without
top-tier autocomplete; this story makes it pleasant to use. Lower priority than the three
above because all three would still ship working without it — but it pays back continuously
in every consumer interaction.

**Independent Test**: A consumer types `Spectrum.color.acce` in Xcode and observes
autocomplete proposing `accent`. Replacing `accent` with the typo `acent` produces a
compiler error pointing to the misspelled identifier.

**Acceptance Scenarios**:

1. **Given** a partial token reference in Xcode, **When** the developer triggers
   autocomplete, **Then** the available subcategories or tokens at that level appear.
2. **Given** a misspelled token identifier in source code, **When** the project is
   compiled, **Then** the compiler emits an error pointing to the misspelled identifier.
3. **Given** the developer hovers over a token reference in Xcode, **When** Quick Help
   activates, **Then** the token's DocC comment is displayed, including its Spectrum
   source path.

---

### Edge Cases

- A consumer references a Spectrum category not yet ported in v0.2.0 (e.g., a future
  category Adobe adds). The compile fails with "no such member" — preventing silent
  drift.
- The Spectrum JSON snapshot contains a token whose value cannot be expressed in the
  target Swift type (e.g., a CSS-specific unit). The generator MUST fail the regenerate
  with a clear error rather than emit a wrong value.
- The Spectrum JSON snapshot adds a new token category between regenerations. The
  generator MUST surface a clear "new category detected" notice; the spec does NOT
  promise auto-handling of unrecognized categories without code review.
- A consumer overrides a token to an invalid value (e.g., a negative spacing). SwiftUI's
  type system rules out non-Color/CGFloat overrides at compile time; semantic-validity
  checks (negative lengths) are out of scope for v0.2.0.
- The user's system has no explicit color scheme preference. SwiftUI's default applies
  (typically light); the package does not introduce a third "system" theme.
- The user has set Dynamic Type to an extreme size (XS or AX5). Typography tokens MUST
  scale gracefully without clipping at the extremes.
- An app runs on macOS where Dynamic Type does not apply. Typography tokens MUST still
  render at a sensible default size; reduce-motion still applies on macOS.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: SpectrumUIFoundations MUST expose all eight token categories: `color`,
  `spacing`, `typography`, `motion`, `elevation`, `radius`, `opacity`, and `sizing`.
- **FR-002**: All token values MUST be generated from a checked-in snapshot of Adobe
  Spectrum's published token JSON via a generator script committed to the repository.
- **FR-003**: The generator MUST be reproducible: running it twice on the same input
  produces byte-identical output. Idempotency is verified in CI.
- **FR-004**: Generated Swift sources MUST be committed to the repository so that
  consumers do NOT need to run the generator to build the library.
- **FR-005**: A snapshot of the source Spectrum JSON MUST be checked in alongside the
  generated Swift sources, in a clearly identified location.
- **FR-006**: Color tokens MUST adapt to the SwiftUI `ColorScheme` automatically — a
  consumer applying a color token does not need to write per-mode logic.
- **FR-007**: Each token category MUST be exposed through a typed Swift hierarchy where
  consumers reference tokens via dotted paths matching the Spectrum hierarchy.
- **FR-008**: Misspelled token identifiers MUST produce a Swift compile error, not a
  runtime fallback or silent default.
- **FR-009**: Consumers MUST be able to override individual tokens via SwiftUI
  Environment values without modifying SpectrumUI source. Overrides scope to the view
  subtree where they are applied.
- **FR-010**: A SwiftUI mechanism (Environment value, modifier, or both) MUST propagate
  the active theme — initially light or dark — through the view hierarchy.
- **FR-011**: Typography tokens MUST honor Dynamic Type scaling on iOS where Spectrum's
  spec calls for scaled text, and MUST render at a sensible default size on macOS.
- **FR-012**: Motion tokens MUST respect the user's "reduce motion" accessibility
  preference per Spectrum's reduce-motion guidance (e.g., shortened or omitted
  animations).
- **FR-013**: The token generator MUST run via a single documented command, executable
  from any clean checkout with no manual setup beyond the project's standard developer
  prerequisites.
- **FR-014**: Each generated token MUST carry a DocC `///` comment that includes (a) a
  one-line description and (b) the path in the source Spectrum JSON that produced the
  token value.
- **FR-015**: Snapshot tests MUST cover at least one token from each of the eight
  categories rendered in both light and dark mode on both macOS 14+ and iOS 17+.
- **FR-016**: A unit test MUST verify that running the generator on the checked-in JSON
  snapshot produces zero diff against the checked-in generated Swift sources (idempotency
  proof).
- **FR-017**: A unit test MUST verify that each generated token's DocC source-path
  comment resolves to a real path in the checked-in JSON snapshot (traceability proof).
- **FR-018**: The library MUST ship exactly two named themes in v0.2.0: `light` and
  `dark`. Additional Spectrum themes (`darkest`, `wireframe`) are out of scope and may
  arrive in a later release.

### Key Entities

- **Token Category**: One of eight named groups (color, spacing, typography, motion,
  elevation, radius, opacity, sizing). Each contains a hierarchical set of tokens.
- **Token**: An atomic design value. Identified by a dotted path (`color.accent.500`),
  belongs to a category, has a Swift type appropriate to its category (Color, CGFloat,
  Font/TextStyle, Duration, etc.), and has a value mapping per theme.
- **Theme**: A named rendering context. v0.2.0 ships `light` and `dark`. A theme defines
  values for the subset of tokens that differ from the default; tokens not specialized
  by the theme inherit a single shared value.
- **Spectrum JSON Snapshot**: A checked-in copy of Adobe's published Spectrum token
  JSON. The single source of truth for token values; the generator's only input.
- **Generator**: The script that transforms the Spectrum JSON Snapshot into Swift token
  source files. Reproducible, idempotent, and runnable from any clean checkout.
- **Override**: A consumer-supplied alternative value for a single token, applied via
  SwiftUI Environment to a view subtree.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A SwiftUI developer can apply any of the eight token categories to a view
  in under 5 lines of code, including the import statement.
- **SC-002**: 100% of tokens shipped in v0.2.0 trace back to a path in the checked-in
  Spectrum JSON snapshot — verified by an automated traceability test.
- **SC-003**: Switching between light and dark mode in a sample app updates token-driven
  visuals within a single view-update cycle, with no recompilation, observable as a
  smooth transition.
- **SC-004**: A misspelled token identifier in consumer code produces a Swift compile
  error within 1 second of the file change in Xcode.
- **SC-005**: Running the token generator twice in a row produces zero diff in the
  working tree.
- **SC-006**: A consumer can override one token (e.g., `accent.500`) at the root of
  their view tree and see exactly that override applied to every descendant view, while
  every other token continues to display its Spectrum default value.
- **SC-007**: A sample app demonstrating all eight token categories renders without
  visual regressions on both macOS 14+ and iOS 17+, in both light and dark mode,
  validated by snapshot tests.
- **SC-008**: A new contributor can run the regenerate command from a fresh clone and
  confirm in under 5 minutes that they have produced the same output the repo already
  contains.

## Assumptions

- **Source JSON origin**: The generator consumes Adobe's `@adobe/spectrum-tokens` package
  (or its publicly downloadable equivalent JSON). The exact source URL and version pin
  are decided at planning time.
- **Generator runtime**: The generator is implemented in Swift (likely as a Swift
  Package Manager command plugin or a small executable target). This keeps the tooling
  stack one-language and avoids introducing JavaScript or Ruby toolchain requirements.
- **Color token type**: Uses SwiftUI's `Color`. Color's built-in light/dark adaptation
  via asset catalogs or per-mode initializers handles theme switching at the type level.
- **Length/spacing/radius/sizing types**: Use `CGFloat`.
- **Typography type**: Uses SwiftUI's `Font` (or a thin Spectrum-defined wrapper). The
  decision between using `Font.TextStyle` (Dynamic Type-aware) vs. raw point sizes per
  token is made at planning time.
- **Motion type**: Uses `Duration` (Swift 5.9+) where available, falling back to
  `TimeInterval` if needed.
- **Elevation type**: Uses a Spectrum-defined struct that captures the shadow geometry
  (offset, blur, color); raw `Shadow` from SwiftUI is too narrow.
- **Theme propagation**: Implemented via SwiftUI's `Environment` system. The active
  theme is an `EnvironmentValue`; consumers apply `.spectrumTheme(.light)` (or similar)
  at the root.
- **Override mechanism**: Per-token overrides use a parallel `Environment` channel —
  consumers apply a `.spectrumColor(\.accent.500, .blue)` style modifier (exact API
  decided at planning time).
- **Themes shipped**: `light` and `dark` only. `darkest` and `wireframe` are deferred.
- **Sample app**: A small in-repo sample target demonstrates token consumption. It is
  test infrastructure, not a shipped product.
- **Existing Foundations stub**: The current `public enum SpectrumUIFoundations`
  namespace with `moduleName` is replaced or extended by the token system. Exact API
  shape decided at planning time; backward compatibility with v0.1.0's `moduleName` is
  not promised (pre-1.0.0 versioning permits breaking changes per the constitution).
- **Out of scope**: Token-aware components (Atoms/Molecules), animation primitives
  beyond the duration tokens themselves, color management for wide-gamut displays
  beyond what SwiftUI provides for free, custom font bundling.
