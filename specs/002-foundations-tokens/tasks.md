---
description: "Task list for feature 002-foundations-tokens"
---

# Tasks: Foundations Token System

**Input**: Design documents from `/specs/002-foundations-tokens/`
**Prerequisites**: plan.md (loaded), spec.md (loaded), research.md, data-model.md, contracts/

**Tests**: Tests are REQUIRED for this feature. `spec.md` FR-015 mandates snapshot
tests across categories × schemes × platforms; FR-016/FR-017 mandate
generator-idempotency and traceability XCTests; Constitution Principle VI mandates
DocC + accessibility + tests for every shipped surface.

**Organization**: Tasks are grouped by user story so each story can ship as an
independently testable increment. Phase 2 is intentionally heavy because the four
user stories share a lot of plumbing (Theme, SpectrumColor, Environment, Generator) —
splitting it across stories would force redundant or interleaved work.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies on incomplete tasks)
- **[Story]**: Maps the task to a user story from `spec.md`
- All file paths are repository-relative

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project layout for the token system + generator + JSON snapshot.

- [X] T001 Create directory tree: `Sources/SpectrumUIFoundations/Theme/`, `Sources/SpectrumUIFoundations/Color/`, `Sources/SpectrumUIFoundations/Tokens/`, `Plugins/GenerateTokens/`, `Tools/SpectrumTokensSnapshot/`. Use `mkdir -p`. The `Tokens/` subdir will hold generator output and starts empty.
- [X] T002 [P] Add the JSON snapshot at `Tools/SpectrumTokensSnapshot/spectrum-tokens.json` by downloading the file (or files) from the pinned `adobe/spectrum-tokens` commit per research R-008. Choose a commit SHA, document it in `Tools/SpectrumTokensSnapshot/README.md` along with the source URL and the date pinned.
- [X] T003 [P] Update `Package.swift`: (a) add `pointfreeco/swift-snapshot-testing` (≥ 1.15) as a package dependency; (b) attach it to test targets only (not library targets); (c) add a `.plugin` entry for `GenerateTokens` under `Plugins/GenerateTokens/`. Do NOT yet declare new source files (those land in subsequent tasks).

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core types, environment plumbing, and the generator. Every user story
needs all of these.

**⚠️ CRITICAL**: No user-story phase can start until Phase 2 is complete and
`swift test` is green.

### Core types (parallelizable — different files)

- [X] T004 Replace `Sources/SpectrumUIFoundations/SpectrumUIFoundations.swift` v0.1.0 stub: remove `moduleName` constant, define `public enum Spectrum` namespace with eight static accessors (`color`, `spacing`, `typography`, `motion`, `elevation`, `radius`, `opacity`, `sizing`). Each accessor returns the corresponding tokens type (forward declarations — bodies fill in via T011's generated tokens).
- [X] T005 [P] Implement `Sources/SpectrumUIFoundations/Color/SpectrumColor.swift`: `public struct SpectrumColor: ShapeStyle, Equatable, Sendable` with `lightHex: UInt32` and `darkHex: UInt32`. Implement `resolve(in:)` that picks the hex based on `EnvironmentValues.colorScheme`, applies any active theme override, and returns a `Color`.
- [X] T006 [P] Implement `Sources/SpectrumUIFoundations/Theme/SpectrumValueTypes.swift` containing `SpectrumFont`, `SpectrumDuration`, `SpectrumElevation` value types per `data-model.md` shapes. All `Equatable` and `Sendable`.
- [X] T007 [P] Implement `Sources/SpectrumUIFoundations/Theme/Theme.swift`: `public struct Theme` with `name`, `base: Theme.Base { case light, dark }`, `overrides: ThemeOverrides`. Add `ThemeOverrides` with `.empty` and typed `setting(_:to:)` helpers per category, each accepting a `KeyPath` into the corresponding tokens namespace.
- [X] T008 [US1] Implement `Sources/SpectrumUIFoundations/Theme/BuiltInThemes.swift`: `public extension Theme { static let light: Theme; static let dark: Theme }`. The bodies wire up to the generated baseline; depends on T011.
- [X] T009 Implement `Sources/SpectrumUIFoundations/Theme/ThemeEnvironmentKey.swift`: `EnvironmentValues.spectrumTheme` (default `.light`) and `View.spectrumTheme(_:)` modifier. Also expose `View.spectrumFont(_:)` (applies font + lineHeight + tracking modifiers per R-005) and `View.spectrumAnimation(_:)` returning a SwiftUI `Animation` resolved against `\.accessibilityReduceMotion` per R-006.

### Generator (parallel to types — different files)

- [X] T010 [P] Implement Generator: SPM command plugin parses color-palette.json + layout.json, emits ColorPaletteTokens.swift (1344 lines, 19 families × ~16 shades), SpacingTokens.swift, RadiusTokens.swift. Each emitted file carries a GENERATED banner + per-token DocC source-path comments. Idempotent (manually verified — running twice produces zero diff). Typography/motion/elevation/opacity/sizing remain hand-curated by design (Adobe does not publish these in a generator-friendly shape).
- [X] T011 Generator output committed: `ColorPaletteTokens.swift` (1344 lines, all 19 families), `SpacingTokens.swift` (15 tokens), `RadiusTokens.swift` (10 tokens). Hand-curated remain by design: `ColorTokens.swift` (semantic shortcuts only), `TypographyTokens.swift`, `MotionTokens.swift`, `ElevationTokens.swift`, `OpacityTokens.swift`, `SizingTokens.swift`. Adobe does not publish those last five in a generator-ready shape (typography is atomic; motion/elevation/opacity/sizing aren't published).

### Test target wiring & green-build verification

- [X] T012 Update `Tests/SpectrumUIFoundationsTests/SpectrumUIFoundationsTests.swift` (inherited from v0.1.0): drop the `moduleName` assertion; instead assert that two real public symbols exist and have plausible values (e.g., `Spectrum.spacing.s100` is a finite `CGFloat > 0`, `Theme.light.name == "light"`).
- [X] T013 Update `Package.swift` `targets` to declare the new files under `SpectrumUIFoundations` (Theme/, Color/, Tokens/) — SPM's source-discovery picks up files by path automatically, so this task is mostly verifying that no extraneous `path:`/`exclude:` overrides are needed and that `swift build` resolves all of `SpectrumUIFoundations` without errors.
- [X] T014 Run `swift test` from the repo root. Expected: every product test target still passes (the four atomic + umbrella tests from v0.1.0) plus the updated `SpectrumUIFoundationsTests` from T012. If any failure, resolve before continuing.

**Checkpoint**: Foundation ready — `Spectrum.*` namespace, value types, theme, and
generator all in place. User-story phases can begin.

---

## Phase 3: User Story 1 — Apply Tokens in SwiftUI Views, Color-Scheme Adaptive (Priority: P1) 🎯 MVP

**Goal**: A SwiftUI consumer can use any of the eight token categories in a view, and
the rendering adapts correctly between light and dark mode.

**Independent Test**: Build a tiny SwiftUI sample view that touches one token from
each category. Render it in both color schemes on macOS and iOS. Snapshot-compare
against committed reference images.

**Reference**: spec.md US1, FR-001, FR-006, FR-007, FR-011, FR-012, FR-015. Plan
research R-002, R-005, R-006.

### Tests for User Story 1 (REQUIRED — FR-015)

- [X] T015 [P] [US1] Create `Tests/SpectrumUIFoundationsTests/ColorSchemeAdaptationTests.swift` with snapshot tests rendering one representative `SpectrumColor` token in both `.light` and `.dark` color schemes on the host platform. Uses `pointfreeco/swift-snapshot-testing`. First run records baselines; subsequent runs verify.
- [X] T016 [P] [US1] Create `Tests/SpectrumUIFoundationsTests/CategoryRenderingTests.swift` with snapshot tests rendering a representative token for each non-color category (spacing, typography, motion frame, elevation shadow, radius corner, opacity overlay, sizing) in both color schemes.
- [X] T017 [P] [US1] Create `Tests/SpectrumUIFoundationsTests/DynamicTypeTests.swift` asserting that `SpectrumFont.textStyle` is preserved end-to-end on iOS — apply a typography token to a `Text`, snapshot at `.large` and `.accessibility3`, verify scaling occurred.
- [X] T018 [P] [US1] Create `Tests/SpectrumUIFoundationsTests/ReduceMotionTests.swift` asserting that `SpectrumDuration.resolve(reduceMotion: true)` returns the reduced variant; that `View.spectrumAnimation(_:)` honors `\.accessibilityReduceMotion`.

### Implementation for User Story 1

- [X] T019 [US1] Wire `Spectrum.color`, `Spectrum.spacing`, …, `Spectrum.sizing` accessors in `Sources/SpectrumUIFoundations/SpectrumUIFoundations.swift` to delegate to the generated `…Tokens` types from T011. Each accessor reads `\.spectrumTheme` from a captured environment when needed.
- [X] T020 [US1] Verify that `Spectrum.color.<token>` resolves correctly given a theme: write a tiny view, embed in a snapshot test, confirm light value renders in `.light` env and dark value in `.dark`. Re-run T015 to confirm green.
- [X] T021 [US1] Run `swift test`. Expected: all five test targets plus the four new test files pass. Investigate and fix any snapshot regressions before continuing.

**Checkpoint**: User Story 1 complete. The library is usable end-to-end for adaptive
token rendering.

---

## Phase 4: User Story 2 — Customize Themes for Brand Adaptation (Priority: P2)

**Goal**: A consumer overrides one or more tokens via a custom `Theme` and sees the
override applied to every descendant view that consumes that token; non-overridden
tokens retain Spectrum defaults; sibling subtrees are unaffected.

**Independent Test**: Construct a `Theme` with a single color override at the root,
embed two sibling views — one inside the override, one outside — snapshot both, verify
expected divergence.

**Reference**: spec.md US2, FR-009, FR-018. Plan research R-004.

### Tests for User Story 2

- [X] T022 [P] [US2] Create `Tests/SpectrumUIFoundationsTests/ThemeOverrideTests.swift`: (a) override a `SpectrumColor` token at root, assert descendant resolution returns the override; (b) assert non-overridden tokens still return Spectrum defaults; (c) sibling subtree isolation — same token outside the override scope returns the default.

### Implementation for User Story 2

- [X] T023 [US2] Implement `ThemeOverrides.setting(_:to:)` for all eight categories in `Sources/SpectrumUIFoundations/Theme/Theme.swift`. Each variant takes a `KeyPath<<Category>Tokens, <ValueType>>` and returns a new `ThemeOverrides` value.
- [X] T024 [US2] Update `SpectrumColor.resolve(in:)` (T005) to consult `EnvironmentValues.spectrumTheme.overrides` before falling back to its embedded `lightHex`/`darkHex`. Same plumbing for `SpectrumFont`, `SpectrumDuration`, `SpectrumElevation`, and the scalar tokens.
- [X] T025 [US2] Run `swift test`. Expected: T022's three sub-cases all green.

**Checkpoint**: User Story 2 complete. Brand customization is supported with a
single, bounded knob.

---

## Phase 5: User Story 3 — Regenerate Tokens from Upstream Spectrum (Priority: P2)

**Goal**: Maintainers can run `swift package generate-tokens` to refresh tokens from
the JSON snapshot. Generation is idempotent and every emitted token traces back to a
valid path in the snapshot.

**Independent Test**: Delete `Sources/SpectrumUIFoundations/Tokens/*.swift`, run the
generator, confirm files reappear and `git status` matches the pre-deletion state.

**Reference**: spec.md US3, FR-002, FR-003, FR-005, FR-013, FR-014, FR-016, FR-017.
Plan research R-001, R-008.

### Tests for User Story 3

- [X] T026 [P] [US3] Create `Tests/SpectrumUIFoundationsTests/GeneratorIdempotencyTests.swift`: invoke the generator's emit logic in-process (refactor T010 so the parsing + emission is a callable function, with the plugin's `performCommand` a thin shell). Run twice, assert byte-identical output. (FR-003, FR-016)
- [X] T027 [P] [US3] Create `Tests/SpectrumUIFoundationsTests/TraceabilityTests.swift`: parse every `Sources/SpectrumUIFoundations/Tokens/*.swift` file, extract the source-JSON-path comment from each generated token, assert each path resolves to a real key path inside `Tools/SpectrumTokensSnapshot/spectrum-tokens.json`. (FR-017)

### Implementation for User Story 3

- [X] T028 [US3] Document the snapshot-refresh ceremony in `Tools/SpectrumTokensSnapshot/README.md`: how to pick a new upstream commit SHA, replace the JSON, re-run the generator, and verify all three checks pass.

**Checkpoint**: User Story 3 complete. The generator is reproducible and the token
catalog is fully traceable to upstream.

---

## Phase 6: User Story 4 — Discover Tokens via Type-Safe APIs (Priority: P3)

**Goal**: Consumers see autocomplete for every token level in Xcode; typos are
compile errors; DocC comments surface in Quick Help.

**Independent Test**: Type a partial token reference in Xcode, observe autocomplete;
introduce a typo, observe compile error; hover a token reference, observe DocC text.

**Reference**: spec.md US4, FR-008, FR-014. Plan research R-003.

### Implementation for User Story 4

- [X] T029 [US4] Verify that the generator (T010) emits per-token DocC `///` comments including a one-line description AND the JSON source path. Inspect a sample of generated tokens to confirm. If gaps, update T010's emitter.
- [X] T030 [US4] Update `Sources/SpectrumUIFoundations/Documentation.docc/Documentation.md` with: (a) a "Token reference" article that links into the eight category namespaces, (b) a "Themes" article with a custom-theme example, (c) a "Reduce motion & Dynamic Type" article documenting accessibility behavior. Run `xcodebuild docbuild -scheme SpectrumUIFoundations` and ensure zero new warnings.

**Checkpoint**: User Story 4 complete. The library is pleasant to discover and use.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Final verification + documentation + release-readiness.

- [X] T031 [P] Walk through `quickstart.md` end-to-end on a fresh clone: clone, `swift test`, regenerate, build a sample consumer app touching all eight categories, toggle light/dark in Xcode preview. Capture any drift between docs and reality and update `quickstart.md`.
- [X] T032 [P] Re-validate `spec.md` Functional Requirements (FR-001..FR-018) and Success Criteria (SC-001..SC-008). Mark each in the PR description as ✅ Verified or ❌ Outstanding.
- [X] T033 Update top-level `README.md`: bump the supported version reference from `0.1.0` to `0.2.0`; add a short "Tokens" section under Products that points at the Foundations DocC; mention the regenerate command in the Quickstart.
- [ ] T034 Tag `v0.2.0` after PR merge per constitution versioning rules. Release ceremony only — does not block PR.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No deps. Can start immediately.
- **Foundational (Phase 2)**: Depends on Setup. Blocks every user-story phase. Heavy.
- **User Story 1 (Phase 3)**: Depends on Phase 2 (specifically T011 produced tokens
  and T009 wired modifiers).
- **User Story 2 (Phase 4)**: Depends on Phase 3's T020 because override resolution
  layers on top of base resolution. Could be parallelized with US3/US4 once US1 lands.
- **User Story 3 (Phase 5)**: Depends only on Phase 2's T010/T011 (the generator
  itself). May proceed in parallel with US1 and US2 — different test files, doesn't
  touch source.
- **User Story 4 (Phase 6)**: Depends on T010 (DocC comments come from the generator)
  and T011 (output to inspect). Independent of US2/US3 implementation.
- **Polish (Phase 7)**: Depends on US1–US4 being complete.

### Phase 2 Internal Dependencies

```
T004 (entry namespace stub) ──┐
                              │
T005 (SpectrumColor)         ─┤
T006 (Spectrum value types)  ─┼──▶ T007 (Theme + ThemeOverrides)
                              │              │
T010 (Generator) ──▶ T011 ────┴──▶ T008 (BuiltInThemes) ──▶ T009 (Env + modifiers)
                                                                    │
                                                                    ▼
                                                T013 (Package.swift target wiring)
                                                                    │
                                                                    ▼
                                                T014 (swift test green)
```

T012 (test update) can run any time after T009 + T011.

### User Story Dependencies (visualization)

```
Setup ── Foundational ── US1 ──┬── US2 ──┐
                               ├── US3 ──┼── Polish
                               └── US4 ──┘
```

US2/US3/US4 can proceed in parallel after US1 lands (T021 green).

### Within Each User Story

- Test tasks come first (or alongside) — they document the exact behavior to implement.
- Implementation closes the loop.
- A `swift test` verification task ends each story's phase.

### Parallel Opportunities

- **Phase 1**: T002 ∥ T003 (after T001).
- **Phase 2**: T005 ∥ T006 ∥ T010 (different files). T007 depends on T005/T006. T008
  depends on T011. T009 depends on T008.
- **Phase 3**: T015 ∥ T016 ∥ T017 ∥ T018 (different test files). T019 ∥ T020 require
  the same source so sequential.
- **Phase 5**: T026 ∥ T027 (different test files).
- **Phase 7**: T031 ∥ T032.

---

## Parallel Example: Phase 2 Foundational

```bash
# Three implementation tasks fully parallel (different files):
Task: "Implement SpectrumColor (T005) in Sources/SpectrumUIFoundations/Color/SpectrumColor.swift"
Task: "Implement Spectrum value types (T006) in Sources/SpectrumUIFoundations/Theme/SpectrumValueTypes.swift"
Task: "Implement GenerateTokens command plugin (T010) in Plugins/GenerateTokens/GenerateTokens.swift"

# Then sequential synchronization at:
Task: "Theme + ThemeOverrides (T007) — depends on T005, T006"
Task: "Run generator (T011) — depends on T010"
Task: "BuiltInThemes (T008) — depends on T011"
Task: "Environment + view modifiers (T009) — depends on T008"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Phase 1 (Setup) → Phase 2 (Foundational, including the generator + token files).
2. Phase 3 (US1) — tests + view-side wiring + green snapshot baseline.
3. **STOP and VALIDATE**: A consumer app can use Spectrum tokens in views, light/dark
   adaptation works. Demoable.

### Incremental Delivery After MVP

- US2 (theme override) — adds the brand-customization knob.
- US3 (generator regen tests) — locks the reproducibility invariant.
- US4 (DocC discovery) — closes the discoverability loop.
- Polish + tag v0.2.0.

### Parallel Team Strategy

- One contributor on Phase 2 generator (T010, T011, T026, T027 across phases).
- One contributor on Phase 2 types + theme (T004–T009).
- Once Phase 2 lands, US1 / US2 / US4 can split across contributors.

---

## Notes

- `[P]` tasks operate on different files with no dependencies on still-incomplete tasks.
- Every user-story task carries a `[USn]` label for traceability back to `spec.md`.
- The generator (T010) is the single biggest task; consider splitting it into JSON
  parsing + per-category emitters during implementation if it grows beyond ~400 LOC.
- Snapshot tests (T015–T018) record baseline images on first run. Reviewers MUST
  inspect those baselines for visual sanity before approving the PR — automated
  snapshot tests only catch regressions, not "the baseline was wrong".
- Avoid: editing the generated `Tokens/*.swift` files by hand — the
  generator-idempotency test (T026) will fail.
