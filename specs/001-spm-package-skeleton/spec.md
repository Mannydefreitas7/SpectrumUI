# Feature Specification: SPM Package Skeleton

**Feature Branch**: `001-spm-package-skeleton`
**Created**: 2026-05-08
**Status**: Draft
**Input**: User description: "SPM package skeleton: Establish the SpectrumUI Swift Package layout that exposes atomically-scoped products as defined in the constitution — SpectrumUI/Foundations, SpectrumUI/Icons, SpectrumUI/Atoms, SpectrumUI/Molecules — plus an optional umbrella SpectrumUI product that re-exports them. Each product is a separate library target with its own test target. Targets are wired with the correct upward-only dependency graph (Atoms→Foundations, Icons→Foundations, Molecules→{Atoms, Icons, Foundations}); circular deps must be impossible. The package supports macOS 14+ and iOS 17+ as platforms, declares Swift 5.9+ tools version, and ships with empty stub source files and at least one passing XCTest per target so `swift test` is green out of the box. CI scaffolding (a single workflow file) builds and tests on both platforms. DocC catalog stubs are present per product. Also include a developer README pointing at the constitution and explaining the layered import rules for consumers."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Trustworthy Out-of-Box Baseline (Priority: P1)

A maintainer or new contributor clones the repository for the first time. With no manual
configuration, no missing-target stubs, and no skipped tests, they run the standard test
command and watch every product's test target build and pass on macOS. They immediately
trust the repository's baseline state and can begin meaningful work.

**Why this priority**: Nothing else matters if the empty package doesn't even compile and
test green. Every downstream feature (Foundations tokens, Atoms components, etc.) depends
on this baseline. If contributors have to "fix the skeleton" to get started, the project's
credibility takes an immediate hit.

**Independent Test**: Clone the repo, run the documented test command, observe a green
result with all product test targets reported as passing.

**Acceptance Scenarios**:

1. **Given** a fresh clone of the repository, **When** a contributor runs the package's
   test command from the root, **Then** every product test target compiles and passes with
   no manual setup steps.
2. **Given** a fresh clone, **When** a contributor opens the package in Xcode, **Then**
   the package resolves successfully and every product target is visible, buildable, and
   testable.
3. **Given** the package is in its initial state, **When** any product test target is run
   in isolation, **Then** it passes with at least one assertion executed.

---

### User Story 2 - Selective Atomic Import for Consumers (Priority: P2)

A SwiftUI developer adds SpectrumUI to their app. They want only what they actually need —
for example, just the design tokens. They depend on the `SpectrumUI/Foundations` product
in their app target, build their app, and only the Foundations module is linked into their
binary. No icons, atoms, or molecules are pulled in.

**Why this priority**: Atomic granularity is the constitution's promise to consumers
(Section: Platform & Tooling Standards). Bundling the entire library into every consumer
target would defeat the purpose. This story validates that promise from the consumer side.

**Independent Test**: Create a tiny sample consumer app, depend on a single non-umbrella
product, build, and confirm the resulting binary does not reference symbols from the other
products.

**Acceptance Scenarios**:

1. **Given** a consumer Swift Package, **When** they declare a dependency on only
   `SpectrumUI/Foundations`, **Then** the build succeeds and Atoms/Molecules/Icons are not
   linked into their target.
2. **Given** a consumer who needs molecules, **When** they declare a dependency on
   `SpectrumUI/Molecules`, **Then** the package graph automatically pulls in Foundations,
   Atoms, and Icons — and only those — to satisfy the upward dependency.
3. **Given** a consumer who wants the whole library quickly, **When** they depend on the
   umbrella `SpectrumUI` product, **Then** they get one import statement (`import
   SpectrumUI`) that re-exports every atomic layer.

---

### User Story 3 - Continuous Integration on Both Apple Platforms (Priority: P2)

A maintainer opens a pull request that touches any product. Continuous integration
automatically builds and tests the package on macOS and iOS. If either platform fails,
the PR is blocked from merging until the failure is resolved.

**Why this priority**: macOS+iOS parity is a constitution principle (V). Without CI
enforcing both platforms on every change, parity drifts within weeks. This story locks
the parity invariant in place from day one.

**Independent Test**: Open a no-op PR; observe CI run a job for each of macOS and iOS,
both reporting build and test results, and the PR cannot be merged while a job is failing.

**Acceptance Scenarios**:

1. **Given** a pull request is opened, **When** CI is triggered, **Then** at least one
   build+test job runs on macOS 14+ and one on iOS 17+.
2. **Given** a PR introduces a build failure on iOS only, **When** CI runs, **Then** the
   PR is reported as failing and merging is blocked.
3. **Given** a push to the default branch, **When** CI runs, **Then** the same matrix of
   platform jobs executes against the merged commit.

---

### User Story 4 - Discoverable Layering Rules for Contributors (Priority: P3)

A new contributor reading the repository top-level documentation can, within minutes,
identify (a) which products exist, (b) what each represents in atomic-design terms, (c)
how the layers may depend on each other, and (d) where the project's governing
constitution lives. They know which product their new component belongs in before writing
any code.

**Why this priority**: Reduces onboarding friction and prevents architectural drift caused
by contributors guessing wrong about layering. Lower priority than the baseline because
the package will function without it — but the package will become disorganized without it.

**Independent Test**: A contributor unfamiliar with the project reads only the README and
correctly answers: "If I'm adding a SearchField component, which product does it go in?"

**Acceptance Scenarios**:

1. **Given** a fresh repository visitor, **When** they open the README, **Then** they see
   the list of products, the atomic-design role of each, and the upward-only layering rule.
2. **Given** the README, **When** the visitor wants to dig deeper into governance, **Then**
   they find a clear link to the project constitution.
3. **Given** any product, **When** a contributor opens its source folder, **Then** they
   find a DocC catalog stub ready to hold long-form documentation.

---

### Edge Cases

- A contributor attempts to introduce a downward dependency (e.g., Foundations depending
  on Atoms). The package declaration MUST make this impossible to express without an
  obvious, unmerged change to the package manifest itself.
- A consumer attempts to use the package on an unsupported platform (e.g., Linux,
  visionOS, tvOS, watchOS, or macOS 13 / iOS 16). The package MUST clearly refuse to build
  with a platform-mismatch error rather than silently failing later.
- A contributor adds a new source file to a product but forgets to add a corresponding
  test. The product test target MUST still pass (because at least one stub test exists),
  but a checklist or review process catches the missing test.
- The umbrella `SpectrumUI` product is imported alongside a sub-product (e.g., `import
  SpectrumUI` plus `import SpectrumUI/Foundations`). The build MUST succeed without
  duplicate-symbol errors.
- A product target is configured with zero source files. The package MUST not enter this
  state — every product ships with at least one stub source file from day one.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The package MUST declare four atomic library products with the exact names
  `SpectrumUIFoundations`, `SpectrumUIIcons`, `SpectrumUIAtoms`, and `SpectrumUIMolecules`,
  corresponding to the constitution's atomic layering. (Product names are flat
  identifiers; the slash-style names like `SpectrumUI/Foundations` are conceptual and used
  in documentation only.)
- **FR-002**: The package MUST declare an umbrella library product named `SpectrumUI`
  that re-exports the four atomic products as a convenience entry point.
- **FR-003**: Each of the five products MUST have its own dedicated library target with at
  least one source file (a stub is acceptable).
- **FR-004**: Each library target MUST have a corresponding test target containing at
  least one passing test that exercises a real assertion (not a no-op).
- **FR-005**: The dependency graph between atomic products MUST flow upward only:
  Foundations has zero internal product dependencies; Icons depends on Foundations only;
  Atoms depends on Foundations only; Molecules depends on Foundations, Icons, and Atoms.
- **FR-006**: The umbrella `SpectrumUI` product MUST depend on every atomic product so
  that consuming the umbrella transitively delivers all layers.
- **FR-007**: Cyclic dependencies between products MUST be impossible by graph
  construction; the package manifest MUST be structured so that introducing a downward
  dependency requires an explicit, reviewable manifest change.
- **FR-008**: The package MUST declare a Swift tools version of 5.9 or higher.
- **FR-009**: The package MUST declare supported platforms of macOS 14 or higher and iOS
  17 or higher, and MUST NOT declare any other platforms in the initial baseline.
- **FR-010**: Running the standard package test command from the repository root on macOS
  MUST result in a green outcome on a clean clone with no manual setup.
- **FR-011**: A continuous integration workflow file MUST exist at the project's standard
  CI location and MUST run a build-and-test job on both macOS 14+ and iOS 17+ for every
  push and pull request.
- **FR-012**: The CI workflow MUST report failures in a way that blocks pull-request merge
  by default.
- **FR-013**: Each product source target MUST contain a DocC catalog stub (an empty `.docc`
  folder structure) so that future documentation can be added without further packaging
  changes.
- **FR-014**: The repository MUST contain a top-level README that documents (a) the
  supported platforms, (b) the list of products and the atomic-design role of each, (c)
  the upward-only layering rule with an example of a forbidden direction, (d) a link to
  the project constitution at `.specify/memory/constitution.md`, and (e) the standard
  command for running tests.
- **FR-015**: Each product's stub source file MUST be a valid empty SwiftUI-friendly file
  (e.g., a public marker type or empty namespace) so that consumers can `import` the
  product without compilation errors.

### Key Entities

- **Atomic Product**: A discrete SPM library product corresponding to one atomic-design
  layer. Has a name, a single source target, a single test target, and a declared list of
  upward dependencies on other atomic products.
- **Umbrella Product**: A library product that re-exports every atomic product, intended
  as a low-friction entry point for consumers who want the full library.
- **Dependency Graph**: The directed acyclic relationship among the atomic products,
  constrained to flow strictly upward.
- **CI Workflow**: The automated pipeline that validates the package on every push and
  pull request, running build and test on each supported Apple platform.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A new contributor can clone the repository and obtain a green test result
  using a single documented command in under 2 minutes on a typical developer machine.
- **SC-002**: 100% of the package's product targets — five of them — have at least one
  passing test on day one.
- **SC-003**: A consumer depending on a single atomic product (e.g., Foundations) builds
  successfully without any source code from the other atomic products being compiled into
  their target.
- **SC-004**: CI runs on every push and pull request and fails the merge gate within 15
  minutes of any build or test regression on either macOS or iOS.
- **SC-005**: A contributor unfamiliar with the project can correctly identify which
  product a hypothetical new component belongs in within 5 minutes of reading the README.
- **SC-006**: Attempting to introduce a downward dependency in the package manifest causes
  the manifest itself to fail validation, preventing any code from compiling against the
  invalid graph.
- **SC-007**: Adding a new sub-product (e.g., a future `Organisms` layer) requires
  changing only the package manifest, the new product's source/test/DocC stubs, and the
  README — not any existing product.

## Assumptions

- **Apple platforms only**: macOS 14+ and iOS 17+ are the only supported platforms in the
  initial baseline. tvOS, watchOS, visionOS, Linux, and Windows are explicitly out of
  scope and may be revisited in a later spec.
- **Distribution is SPM only**: CocoaPods, Carthage, and binary distribution are out of
  scope.
- **Test framework is XCTest**: Aligns with the user description and Swift Package Manager
  conventions. Swift Testing may be adopted in a future spec.
- **CI provider is GitHub Actions**: Industry default for open-source Swift packages and
  the most ergonomic option for matrix builds across Apple platforms. The workflow lives
  at `.github/workflows/ci.yml`.
- **DocC catalog stubs are empty placeholders**: An empty `.docc` folder per product is
  sufficient for this feature. Populating documentation is the responsibility of each
  component-level feature.
- **Source stubs are minimal**: Each product ships with one stub source file (e.g., an
  empty public namespace type) — sufficient for the target to compile but containing no
  real functionality.
- **Product naming**: SPM product names use flat identifiers (e.g., `SpectrumUIFoundations`)
  because SPM does not allow slashes in product names. The constitution's
  `SpectrumUI/Foundations` notation is conceptual; documentation refers to products both
  ways for clarity.
- **No external runtime dependencies**: The skeleton has zero non-Apple-platform external
  dependencies; the only "deps" are the inter-product upward links.
- **Repository hosting**: The project is hosted on GitHub (informs the CI choice).
- **Git LFS, code signing, and release automation**: Out of scope for the skeleton; those
  are separate features.
