---
description: "Task list for feature 001-spm-package-skeleton"
---

# Tasks: SPM Package Skeleton

**Input**: Design documents from `/specs/001-spm-package-skeleton/`
**Prerequisites**: plan.md (loaded), spec.md (loaded), research.md, data-model.md, contracts/

**Tests**: Tests are REQUIRED (not optional) for this feature — `spec.md` FR-004 mandates
≥1 real-assertion XCTest per product target, and the constitution's Principle VI makes
this non-negotiable. Test tasks below are first-class, not optional.

**Organization**: Tasks are grouped by user story so each story can ship as an
independently testable increment. The four user stories from `spec.md` map to phases
3–6 below.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Maps the task to a user story from `spec.md`
- All file paths are repository-relative

## Path Conventions

- Source files live under `Sources/<TargetName>/`
- Test files live under `Tests/<TargetName>Tests/`
- Single Swift Package; one `Package.swift` at repo root

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Create the empty repository scaffolding every subsequent task assumes.

- [X] T001 Create the source/test/CI directory tree per the project structure in `plan.md`: `Sources/SpectrumUIFoundations/`, `Sources/SpectrumUIIcons/`, `Sources/SpectrumUIAtoms/`, `Sources/SpectrumUIMolecules/`, `Sources/SpectrumUI/`, the matching `Tests/<Name>Tests/` siblings, and `.github/workflows/`. Use `mkdir -p`; do not commit empty dirs (placeholder files come in later tasks).
- [X] T002 [P] Create `.gitignore` at repo root with Swift Package Manager defaults: `.build/`, `.swiftpm/`, `Package.resolved` (debatable — keep for libraries), `*.xcodeproj/`, `DerivedData/`, `.DS_Store`, `xcuserdata/`. Reference: standard SwiftPM library `.gitignore`.
- [X] T003 [P] Create the initial `Package.swift` at repo root with only the `// swift-tools-version: 5.9` header line, the `import PackageDescription` line, and a single empty `Package(name: "SpectrumUI")` declaration. The package will not yet build successfully; subsequent tasks fill it in.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Bring `Package.swift` to a state that all five user stories can build on.

**⚠️ CRITICAL**: User-story phases (3–6) all touch `Package.swift`. Phase 2 establishes
the manifest's platform and version baseline so later edits only add products/targets
without revisiting these.

- [X] T004 Update `Package.swift` to declare `platforms: [.macOS(.v14), .iOS(.v17)]` and add empty `products: []` and `targets: []` arrays inside the `Package(...)` initializer. The package now resolves without errors and reports zero products via `swift package describe`.

**Checkpoint**: Foundation ready — user-story implementation can begin.

---

## Phase 3: User Story 1 — Trustworthy Out-of-Box Baseline (Priority: P1) 🎯 MVP

**Goal**: A fresh clone runs `swift test` and gets a green result with all four atomic
product test targets passing.

**Independent Test**: Clone the repo, run `swift test` from the root, observe four test
targets reported and all assertions passing in under 2 minutes.

**Reference**: spec.md US1, FR-001, FR-003, FR-004, FR-005, FR-006, FR-007, FR-008,
FR-010, FR-015. Research R-001, R-005, R-007.

### Implementation for User Story 1

- [X] T005 [P] [US1] Create `Sources/SpectrumUIFoundations/SpectrumUIFoundations.swift` with a `public enum SpectrumUIFoundations` namespace, a `public static let moduleName = "SpectrumUIFoundations"`, and a DocC `///` doc comment describing the layer's role (tokens, theme primitives, shared utilities; zero deps). Pattern per research R-007.
- [X] T006 [P] [US1] Create `Sources/SpectrumUIIcons/SpectrumUIIcons.swift` with a `public enum SpectrumUIIcons` namespace, `public static let moduleName = "SpectrumUIIcons"`, and a DocC `///` doc comment describing its role (icon assets, SF Symbol bridging; depends on Foundations).
- [X] T007 [P] [US1] Create `Sources/SpectrumUIAtoms/SpectrumUIAtoms.swift` with a `public enum SpectrumUIAtoms` namespace, `public static let moduleName = "SpectrumUIAtoms"`, and a DocC `///` doc comment describing its role (primitive components; depends on Foundations).
- [X] T008 [P] [US1] Create `Sources/SpectrumUIMolecules/SpectrumUIMolecules.swift` with a `public enum SpectrumUIMolecules` namespace, `public static let moduleName = "SpectrumUIMolecules"`, and a DocC `///` doc comment describing its role (composed components; depends on Foundations + Icons + Atoms).
- [X] T009 [P] [US1] Create `Tests/SpectrumUIFoundationsTests/SpectrumUIFoundationsTests.swift` containing one `XCTestCase` subclass with a `func testProductIsImportable()` that asserts `XCTAssertEqual(SpectrumUIFoundations.moduleName, "SpectrumUIFoundations")`. Pattern per research R-005.
- [X] T010 [P] [US1] Create `Tests/SpectrumUIIconsTests/SpectrumUIIconsTests.swift` analogous to T009, asserting `SpectrumUIIcons.moduleName == "SpectrumUIIcons"`.
- [X] T011 [P] [US1] Create `Tests/SpectrumUIAtomsTests/SpectrumUIAtomsTests.swift` analogous to T009, asserting `SpectrumUIAtoms.moduleName == "SpectrumUIAtoms"`.
- [X] T012 [P] [US1] Create `Tests/SpectrumUIMoleculesTests/SpectrumUIMoleculesTests.swift` analogous to T009, asserting `SpectrumUIMolecules.moduleName == "SpectrumUIMolecules"`.
- [X] T013 [US1] Update `Package.swift` to declare four library products and their backing targets — `SpectrumUIFoundations`, `SpectrumUIIcons`, `SpectrumUIAtoms`, `SpectrumUIMolecules` — plus four test targets. Wire the **upward-only** dependency graph exactly per `data-model.md`: Foundations target has zero internal deps; Icons depends on `SpectrumUIFoundations`; Atoms depends on `SpectrumUIFoundations`; Molecules depends on `SpectrumUIFoundations`, `SpectrumUIIcons`, `SpectrumUIAtoms`. Each test target depends only on its paired library target. Depends on T005–T012.
- [X] T014 [US1] From repo root, run `swift test` and verify: package resolves, builds, and reports four passing test targets (one assertion each). Resolve any failure before proceeding. This validates SC-001, SC-002, SC-003, and the upward-only graph (SC-006: try inserting `import SpectrumUIAtoms` into the Foundations stub, observe build failure, then revert).

**Checkpoint**: User Story 1 done — MVP is shippable. The package builds and tests pass
on macOS from a fresh clone with no manual setup.

---

## Phase 4: User Story 2 — Selective Atomic Import + Umbrella (Priority: P2)

**Goal**: Consumers can depend on a single atomic product OR the umbrella `SpectrumUI`
product, and either path works.

**Independent Test**: A consumer Swift Package depending on `SpectrumUIFoundations` (and
nothing else) builds with only Foundations symbols available; a consumer depending on
`SpectrumUI` gets symbols from all four atomic layers via one import.

**Reference**: spec.md US2, FR-002, FR-006, FR-015. Research R-002.

### Implementation for User Story 2

- [X] T015 [P] [US2] Create `Sources/SpectrumUI/SpectrumUI.swift` containing only `@_exported import SpectrumUIFoundations`, `@_exported import SpectrumUIIcons`, `@_exported import SpectrumUIAtoms`, `@_exported import SpectrumUIMolecules`, plus a DocC `///` doc comment explaining the umbrella role and a brief note about the underscored attribute (per research R-002 caveat).
- [X] T016 [P] [US2] Create `Tests/SpectrumUITests/SpectrumUITests.swift` with a single `XCTestCase` that imports `SpectrumUI` and asserts each atomic product's `moduleName` is reachable through the umbrella (four `XCTAssertEqual` calls — one per atomic product).
- [X] T017 [US2] Update `Package.swift` to add the umbrella library product `SpectrumUI`, its source target depending on all four atomic targets, and the matching `SpectrumUITests` test target depending only on `SpectrumUI`. Depends on T015, T016, T013.
- [X] T018 [US2] Run `swift test` and verify five test targets now pass. Verify selective import by adding a temporary throwaway target depending on only `SpectrumUIFoundations` and confirming `swift build` produces a binary that does not link the other atomic modules (use `swift build -v` and inspect the link command). Revert the throwaway target before committing.

**Checkpoint**: User Story 2 done — selective and umbrella consumption paths both work.

---

## Phase 5: User Story 3 — CI on Both Apple Platforms (Priority: P2)

**Goal**: Every push and pull request is built and tested on both macOS 14+ and iOS 17+
in CI; failures block merge.

**Independent Test**: Push the branch; observe two parallel CI jobs (macOS + iOS) on the
PR; introduce a deliberate test failure on a throwaway branch and confirm the PR's merge
button is blocked.

**Reference**: spec.md US3, FR-009, FR-011, FR-012. Research R-003.

### Implementation for User Story 3

- [X] T019 [US3] Create `.github/workflows/ci.yml` with: triggers `push` and `pull_request`; one job named `build-and-test` running on `macos-14`; matrix `platform: [macOS, iOS]`; steps for checkout, Xcode select (pin to a specific version per R-003 — e.g., `15.4`), and a conditional run step — `swift test` for `platform == macOS`, `xcodebuild test -scheme SpectrumUI-Package -destination 'platform=iOS Simulator,name=iPhone 15,OS=17.5'` for `platform == iOS`.
- [ ] T020 [US3] Push the branch to GitHub and confirm both matrix jobs run, build, and pass. If the repo has no remote yet, create one (out of scope for this task list — handled by `/speckit-git-remote` or repo-admin setup); document the commit SHA at which CI was first green in the PR description.
- [ ] T021 [US3] In GitHub repo settings, configure branch protection on the default branch (`main`) to require both `build-and-test (macOS)` and `build-and-test (iOS)` status checks before merge. This is a repo-admin task and is performed in the GitHub UI (or via `gh api` from a maintainer's local CLI); no file changes in the repo.

**Checkpoint**: User Story 3 done — parity is enforced by CI for every change.

---

## Phase 6: User Story 4 — Discoverable Layering Rules (Priority: P3)

**Goal**: A new contributor reading top-level docs can identify the products, their
roles, and the upward-only layering rule within five minutes; each product has a DocC
catalog ready for future docs.

**Independent Test**: A contributor unfamiliar with the project reads only `README.md`
and correctly answers: "If I'm adding a `SearchField` component, which product does it
go in?" (Expected answer: Molecules.)

**Reference**: spec.md US4, FR-013, FR-014, SC-005. Research R-004.

### Implementation for User Story 4

- [X] T022 [P] [US4] Create `Sources/SpectrumUIFoundations/Documentation.docc/Documentation.md` containing a single Markdown line — a top-level heading referencing the module: `` # ``SpectrumUIFoundations`` `` — plus a one-paragraph stub describing the layer. Per research R-004.
- [X] T023 [P] [US4] Create `Sources/SpectrumUIIcons/Documentation.docc/Documentation.md` analogous to T022.
- [X] T024 [P] [US4] Create `Sources/SpectrumUIAtoms/Documentation.docc/Documentation.md` analogous to T022.
- [X] T025 [P] [US4] Create `Sources/SpectrumUIMolecules/Documentation.docc/Documentation.md` analogous to T022.
- [X] T026 [P] [US4] Create `Sources/SpectrumUI/Documentation.docc/Documentation.md` describing the umbrella product and listing the four atomic products it re-exports.
- [X] T027 [US4] Create `README.md` at repository root with these sections, in this order: (1) **Supported platforms** — macOS 14+, iOS 17+; (2) **Products** — the five products with their atomic-design role and a one-sentence description; (3) **Layering rules** — the upward-only edge table from `data-model.md` plus a forbidden-direction example (e.g., "❌ Foundations may not import Atoms"); (4) **Quickstart** — clone + `swift test`; (5) **Constitution** — link to `.specify/memory/constitution.md` with a one-sentence framing of what it governs.
- [X] T028 [US4] Run `swift package generate-documentation` from repo root and verify it completes with zero warnings. If DocC build is unavailable in the local toolchain, document the verification command in the PR description and mark this verified by a CI job in a follow-up.

**Checkpoint**: User Story 4 done — the project is self-explanatory to new contributors.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Final validation across all stories and ceremonial closeout.

- [X] T029 [P] Walk through `quickstart.md` end-to-end on a freshly cloned copy of the branch (separate clone in `/tmp` or similar). Each command MUST run as documented; capture any drift between docs and reality and update `quickstart.md` accordingly.
- [X] T030 [P] Re-validate `spec.md` Functional Requirements (FR-001 through FR-015) and Success Criteria (SC-001 through SC-007) item by item. Mark each as ✅ Verified or ❌ Outstanding in a brief PR-description checklist.
- [ ] T031 Tag the merge commit `v0.1.0` per research R-006. This is a release-ceremony task and runs after the PR merges to `main`; it does not block the PR itself.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — can start immediately.
- **Foundational (Phase 2)**: Depends on Setup. Blocks every user-story phase.
- **User Story 1 (Phase 3)**: Depends on Foundational. The MVP — must finish before any
  later story can be claimed "shippable".
- **User Story 2 (Phase 4)**: Depends on User Story 1 (the umbrella re-exports atomic
  products that US1 created). Cannot start before T013 is done.
- **User Story 3 (Phase 5)**: Depends on User Story 1's `swift test` greenness (T014)
  for the macOS axis to have anything to test. iOS axis depends on the same target set.
  US3 does NOT depend on US2 (CI runs against whatever products exist).
- **User Story 4 (Phase 6)**: Depends only on the source target directories existing
  (T005–T008, T015). Can start as soon as those source files are in place. US4 does
  NOT block any other story.
- **Polish (Phase 7)**: Depends on all four user stories being complete.

### User Story Dependencies (visualization)

```
Setup(P1) ── Foundational(P2) ── US1(P3) ──┬── US2(P4) ──┬── Polish(P7)
                                           ├── US3(P5) ──┤
                                           └── US4(P6) ──┘
```

US2, US3, US4 may proceed in parallel after US1's checkpoint (T014) is reached, given
team capacity.

### Within Each User Story

- All `[P]`-marked tasks within a story can run concurrently (different files).
- The `Package.swift` edit task in each story is the synchronization point — it consumes
  the parallel source/test creations and depends on all of them.
- Verification tasks (T014, T018, T020, T028) come last in their phase.

### Parallel Opportunities

- **Phase 1**: T002 and T003 can run in parallel after T001.
- **Phase 3**: T005–T012 (eight tasks) can run fully in parallel.
- **Phase 4**: T015 and T016 can run in parallel.
- **Phase 6**: T022–T026 (five tasks) can run fully in parallel.
- **Phase 7**: T029 and T030 can run in parallel.

---

## Parallel Example: User Story 1

```bash
# Stub source files (4 in parallel):
Task: "Create Sources/SpectrumUIFoundations/SpectrumUIFoundations.swift (T005)"
Task: "Create Sources/SpectrumUIIcons/SpectrumUIIcons.swift (T006)"
Task: "Create Sources/SpectrumUIAtoms/SpectrumUIAtoms.swift (T007)"
Task: "Create Sources/SpectrumUIMolecules/SpectrumUIMolecules.swift (T008)"

# Test files (4 in parallel; can interleave with source creation):
Task: "Create Tests/SpectrumUIFoundationsTests/SpectrumUIFoundationsTests.swift (T009)"
Task: "Create Tests/SpectrumUIIconsTests/SpectrumUIIconsTests.swift (T010)"
Task: "Create Tests/SpectrumUIAtomsTests/SpectrumUIAtomsTests.swift (T011)"
Task: "Create Tests/SpectrumUIMoleculesTests/SpectrumUIMoleculesTests.swift (T012)"

# Sync point — sequential, depends on the eight above:
Task: "Wire 4 products + targets + dep graph in Package.swift (T013)"
Task: "Run swift test and verify green (T014)"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1 (Setup) and Phase 2 (Foundational).
2. Complete Phase 3 (User Story 1).
3. **STOP and VALIDATE**: `swift test` is green from a fresh clone.
4. The repository is now in a usable, demonstrable state — even before umbrella, CI, or
   docs land.

### Incremental Delivery

After MVP, deliver in priority order or in parallel as capacity allows:

1. US2 (umbrella) — adds the convenience consumption path.
2. US3 (CI) — locks parity in place; ideally lands quickly after US1 to protect the
   baseline.
3. US4 (README + DocC stubs) — finishes the contributor-facing story.
4. Phase 7 polish + tag `v0.1.0`.

### Parallel Team Strategy

With multiple contributors:

1. Whole team finishes Phases 1–3 (the MVP).
2. After T014 (MVP green), split: one contributor takes US2, another takes US3, a third
   takes US4. They work concurrently, only colliding briefly on `Package.swift` (US2)
   and the README (US4); US3 has no shared-file conflicts.
3. Final reviewer runs Phase 7.

---

## Notes

- `[P]` tasks operate on different files with no dependencies on still-incomplete tasks.
- Every user-story task carries a `[USn]` label for traceability back to `spec.md`.
- The `Package.swift` editing tasks (T013, T017) are the natural sync points — they
  cannot run in parallel with each other and cannot start until their phase's parallel
  tasks complete.
- Commit after each task or each `Package.swift` sync point to keep history auditable.
- Stop at any checkpoint to validate the corresponding user story independently.
- Avoid: editing the same file in parallel; introducing dependencies that break a
  story's independent-test claim; bundling unrelated work into the `Package.swift`
  sync-point commits.
