<!--
SYNC IMPACT REPORT
==================
Version change: (uninitialized template) → 1.0.0
Bump rationale: Initial ratification — first concrete constitution replacing the
unfilled template. Treated as the project's 1.0.0 baseline.

Principles defined (6):
- I.   Spectrum Fidelity (NON-NEGOTIABLE)
- II.  Experience Parity & Constrained Customization
- III. Token-First Architecture
- IV.  SwiftUI-Native API
- V.   macOS + iOS Parity
- VI.  Accessibility, Documentation & Test Discipline

Sections added:
- Platform & Tooling Standards
- Development Workflow & Quality Gates
- Governance

Sections removed: none (template placeholders replaced).

Template alignment:
- ✅ .specify/templates/plan-template.md — Constitution Check gate is content-driven; no edit required.
- ✅ .specify/templates/spec-template.md — no constitution-specific tokens; no edit required.
- ✅ .specify/templates/tasks-template.md — no constitution-specific tokens; no edit required.
- ✅ .specify/templates/checklist-template.md — no constitution-specific tokens; no edit required.

Runtime guidance docs:
- ⚠ README.md — not present in repo; create when project documentation is authored.

Deferred TODOs: none.
-->

# SpectrumUI Constitution

SpectrumUI is a SwiftUI port of the Adobe Spectrum Design System — tokens, foundations, and
components — targeting macOS and iOS. This constitution governs how the library is designed,
built, tested, and evolved. It binds every contribution.

## Core Principles

### I. Spectrum Fidelity (NON-NEGOTIABLE)

Tokens, components, and behaviors MUST match Adobe Spectrum's published specifications.
Visual or behavioral deviations from Spectrum require an explicit, documented rationale in
the source file alongside a link to the Spectrum reference. When upstream Spectrum specs
change, SpectrumUI MUST be updated to track them; lagging behind is technical debt and MUST
be tracked as such.

**Rationale**: The library's only reason to exist is to bring Spectrum to SwiftUI. Drift
from Spectrum erodes that value proposition.

### II. Experience Parity & Constrained Customization

Fidelity is not limited to static visuals. Components MUST faithfully port the full Spectrum
**experience**: animations and motion curves, interaction states (hover, focus, pressed,
selected, disabled, loading, error), and the defined size scale (e.g., XS / S / M / L / XL
or whatever Spectrum specifies for that component).

The library MUST provide a reasonable customization surface — color overrides, spacing
scale adjustments, density preferences, theming hooks — exposed through the token system
and well-defined SwiftUI environment values. However, customization MUST NOT replace
Spectrum's design language. Where Spectrum has an opinion, that opinion is the default and
the recommended path. Custom one-off visual tweaks at the call site are discouraged and
MUST NOT be required to use the library.

**Rationale**: Consumers want Spectrum, not a customizable component kit. Customization
exists to support theming and brand adaptation, not to encourage divergence.

### III. Token-First Architecture

Design tokens (color, spacing, typography, motion, elevation, radius, opacity, sizing) are
the single source of truth. Components MUST consume tokens through the typed token system;
raw literals — hex strings, magic point values, system fonts, hard-coded durations — are
forbidden in component code. Token updates MUST propagate to all consumers without
component refactors.

**Rationale**: Tokens are how a design system stays coherent and how Spectrum updates
flow through the library cheaply.

### IV. SwiftUI-Native API

Public component APIs MUST be idiomatic SwiftUI: `View` and `ViewModifier` composition,
`@Environment` for cross-cutting concerns (theme, density, color scheme), `@Binding` and
`@State` for state, value-type configuration. UIKit and AppKit types MUST NOT appear in
the public API surface. Concepts borrowed from web/CSS heritage (className strings, inline
style dictionaries, CSS-in-Swift) MUST NOT leak through.

**Rationale**: The library's audience is SwiftUI developers. An idiomatic API is the
contract that earns adoption.

### V. macOS + iOS Parity

Every shipped component MUST support both macOS 14+ and iOS 17+ from a single shared
implementation. Platform-specific affordances (hover, context menus, focus rings, key
equivalents on macOS; haptics, swipe actions on iOS) are opt-in via conditional modifiers
and MUST NOT fork the component into separate codepaths. Platform divergences MUST be
documented in the component's DocC comment.

**Rationale**: Forks double maintenance cost and inevitably drift apart.

### VI. Accessibility, Documentation & Test Discipline

Every component MUST ship with all four of the following before it can be marked stable:

1. **Unit tests** — at minimum a simple unit test covering the component's state and logic.
2. **Snapshot tests** — covering light and dark themes, all defined size variants, and
   every supported platform (macOS, iOS).
3. **Accessibility** — VoiceOver labels and traits, Dynamic Type support, keyboard
   navigation on macOS, and WCAG 2.1 AA contrast for default themes.
4. **DocC-ready documentation** — public types, initializers, and modifiers MUST carry
   DocC-format documentation comments (`///`) describing purpose, parameters, and a usage
   example. Public API without DocC comments is a blocking PR review issue.

**Rationale**: A design system library lives or dies by its docs and test coverage —
they're how consumers trust and discover it.

## Platform & Tooling Standards

- **Language**: Swift 5.9+
- **UI framework**: SwiftUI
- **Distribution**: Swift Package Manager (SPM)
- **Targets**: macOS 14+, iOS 17+
- **Token source**: Generated from Adobe Spectrum's published token specifications;
  generation is reproducible and checked in.

**SPM Module Structure**: The package MUST expose atomically-scoped products so consumers
can import only what they need. The structure follows atomic-design layering:

- `SpectrumUI/Foundations` — tokens, theme primitives, color/typography/spacing scales,
  shared utilities. No component code.
- `SpectrumUI/Icons` — icon assets and SF Symbol bridging. Depends on `Foundations`.
- `SpectrumUI/Atoms` — primitive components (Button, Checkbox, TextField, Badge, etc.).
  Depends on `Foundations` and may depend on `Icons`.
- `SpectrumUI/Molecules` — composed components (e.g., SearchField, Card, Toast).
  Depends on `Foundations`, `Atoms`, and `Icons`.
- Additional layers (e.g., `Organisms`, `Patterns`) MAY be added following the same
  atomic-design discipline; each new layer MUST justify its existence in its README.
- A top-level `SpectrumUI` umbrella product MAY re-export the layers for convenience but
  MUST NOT be the only consumption path.

Cross-layer dependencies flow upward only (Atoms → Foundations, never Foundations → Atoms).
Circular dependencies between products are forbidden.

## Development Workflow & Quality Gates

- **Code review**: Every change requires at least one approving review. Reviewers MUST
  verify constitution compliance, especially Principles I, II, III, and VI.
- **CI gates**: Unit tests, snapshot tests, and DocC build MUST all pass on both macOS and
  iOS before merge. Snapshot diffs require explicit reviewer acknowledgment.
- **Versioning**: Semantic versioning. Public-API breaking changes require a MAJOR bump
  and a migration note in the release notes. Adding a component or non-breaking token is
  MINOR. Bug fixes and Spectrum-spec catch-up patches that don't change API are PATCH.
- **Spectrum upstream sync**: Token regeneration runs are committed as their own PR with
  a diff summary; component-level spec updates are separate PRs that reference the
  Spectrum changelog.

## Governance

This constitution supersedes ad-hoc practices. All PRs and reviews MUST verify compliance
with the principles above; non-compliance MUST be either fixed or explicitly justified in
the PR description.

**Amendments**: Constitution changes are themselves a PR that:

1. Documents the rationale and impact.
2. Bumps `CONSTITUTION_VERSION` per semver:
   - **MAJOR** — backward-incompatible governance or principle removal/redefinition.
   - **MINOR** — a new principle or a materially expanded section.
   - **PATCH** — clarifications, wording, typo fixes, non-semantic refinements.
3. Propagates updates to dependent templates (`plan-template.md`, `spec-template.md`,
   `tasks-template.md`, `checklist-template.md`) and runtime docs.
4. Updates `LAST_AMENDED_DATE`.

**Compliance review**: Constitution adherence is reviewed at every PR. A periodic audit
SHOULD be performed each minor release to catch slow drift.

**Version**: 1.0.0 | **Ratified**: 2026-05-08 | **Last Amended**: 2026-05-08
