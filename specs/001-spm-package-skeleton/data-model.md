# Phase 1 Data Model: SPM Package Skeleton

**Feature**: 001-spm-package-skeleton
**Date**: 2026-05-09

This feature has no runtime data model in the conventional sense — there is no
persistence, no API payloads, no domain entities. The "data" of the skeleton is its
**package configuration**: the set of products, targets, and dependency edges encoded
in `Package.swift`. This document describes those entities, their attributes, validation
rules, and the (one-way) transitions they undergo when the package is extended.

## Entities

### 1. Product

The top-level unit consumers depend on.

| Attribute | Type | Description |
|-----------|------|-------------|
| `name` | String | Flat identifier (no slashes). e.g. `SpectrumUIFoundations`. |
| `kind` | enum {`atomic`, `umbrella`} | Whether it represents a single layer or re-exports all layers. |
| `layer` | enum {`foundations`, `icons`, `atoms`, `molecules`, `umbrella`} | Atomic-design role. |
| `targetName` | String | The library target backing this product. By convention equal to `name`. |

**Validation**:

- `name` MUST start with `SpectrumUI` and use PascalCase suffix.
- The set of `layer` values MUST contain each of `foundations`, `icons`, `atoms`,
  `molecules` exactly once, plus `umbrella` exactly once. (Total: 5 products in the
  initial baseline.)
- Exactly one product MUST have `kind == umbrella` and its `name` MUST be `SpectrumUI`.

### 2. Target

The compiled unit. Two kinds: source target (library) and test target.

| Attribute | Type | Description |
|-----------|------|-------------|
| `name` | String | Identifier matching the directory under `Sources/` or `Tests/`. |
| `kind` | enum {`library`, `test`} | Source or test. |
| `productName` | String? | For library targets, the `Product.name` it backs. For test targets, the library it tests. |
| `dependencies` | [String] | Other target names this target imports. Library targets list product targets only; test targets list the single library they cover. |

**Validation**:

- Each Product has exactly one library target and exactly one test target paired with it.
- `dependencies` MUST appear only as edges allowed by the Dependency Graph below.
- Library target `dependencies` MUST be a subset of the upward set defined in the
  Dependency Graph for that target's `layer`.
- Test target `dependencies` MUST contain its paired library target and nothing else
  unless explicitly justified.

### 3. Dependency Graph

The set of edges between library targets. Edges are directed; the source target imports
the destination target.

**Allowed edges** (and only these):

| From layer | To layers |
|------------|-----------|
| `foundations` | (none) |
| `icons` | `foundations` |
| `atoms` | `foundations` |
| `molecules` | `foundations`, `icons`, `atoms` |
| `umbrella` | `foundations`, `icons`, `atoms`, `molecules` |

**Validation**:

- The graph MUST be acyclic.
- An edge from a higher layer to a lower layer (e.g., `foundations` → `atoms`) MUST NOT
  exist. This is what "upward-only" means.
- Lateral edges within the same layer (e.g., `atoms` → `icons` if `icons` were treated
  as same-tier) are NOT permitted in the initial baseline; the table above lists every
  allowed edge.

### 4. CI Workflow

The configuration that runs the package on each push.

| Attribute | Type | Description |
|-----------|------|-------------|
| `path` | String | Relative path to the workflow file. Fixed: `.github/workflows/ci.yml`. |
| `triggers` | [String] | Events that fire the workflow. Required: `push`, `pull_request`. |
| `matrix.platform` | [String] | Required: `[macOS, iOS]`. |
| `matrix.runner` | String | Required: `macos-14` (or successor; pinned). |
| `xcodeVersion` | String | Required: pinned (e.g., `15.4`). |

**Validation**:

- Both platform axes MUST appear; removing either is a constitution violation
  (Principle V).
- Every job MUST execute one build step and one test step.
- Failure on either platform MUST mark the workflow run as failed.

### 5. DocC Catalog

A documentation bundle attached to a library target.

| Attribute | Type | Description |
|-----------|------|-------------|
| `path` | String | `Sources/<TargetName>/Documentation.docc/` |
| `seedFile` | String | `Documentation.md` containing a single `# \`\`<TargetName>\`\`` heading line. |

**Validation**:

- Each library target (5 of them) MUST have exactly one DocC catalog.
- Each catalog MUST contain at least one Markdown file (the seed) so DocC builds without
  warnings.

### 6. README

A single Markdown file at the repository root.

| Required content | |
|------------------|--|
| Supported platforms section | macOS 14+, iOS 17+ |
| Products section | List of 5 products + atomic-design role |
| Layering rules section | Upward-only edge table + a forbidden-direction example |
| Constitution link | `.specify/memory/constitution.md` |
| Quickstart section | The standard test command (`swift test`) |

**Validation**: All five sections MUST be present and detectable by a contributor scan
within five minutes (SC-005).

## State Transitions

The skeleton supports exactly one transition: **adding a new layer** (e.g., a future
`Organisms` product). When that happens:

```
[5-product baseline] ──add Organisms──▶ [6-product baseline]
```

The transition rules:

1. The new layer MUST be added to Product's `layer` enum and the Dependency Graph table
   above (in spec/data-model docs).
2. The Dependency Graph MUST gain a new row for the layer's allowed upward set, AND
   the umbrella's row MUST be updated to include the new layer.
3. The README's Products section and Layering rules section MUST be updated.
4. No existing target's source files need to change (SC-007).

Any transition that does not satisfy these four points is invalid and MUST be rejected
in code review.

## Relationships Summary

```
Product (1)──(1) library Target ──(1)──(1) DocC Catalog
                       │
                       │ (1)──(1)
                       ▼
                  test Target
```

```
Dependency Graph edges (upward-only):
foundations  ──┬──▶ icons    ──┬─▶ molecules ──┐
               └──▶ atoms    ──┘               ├─▶ umbrella
                                               │
foundations ───────────────────────────────────┘
```
