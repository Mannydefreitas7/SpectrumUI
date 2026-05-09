# Spectrum Tokens Snapshot

This directory holds a checked-in snapshot of Adobe's published Spectrum design tokens.
It is the **single source of truth** for every token value SpectrumUI ships. The
generator at `Plugins/GenerateTokens/` reads these files and emits Swift source into
`Sources/SpectrumUIFoundations/Tokens/`.

## Pinned source

- **Repository**: https://github.com/adobe/spectrum-design-data (renamed from
  `adobe/spectrum-tokens`; npm package name remains `@adobe/spectrum-tokens`)
- **Commit SHA**: `c970c1e4adbc`
- **Date pinned**: 2026-05-09
- **Source path**: `packages/tokens/src/*.json`

## Files

| File | Size | Source category |
|------|------|-----------------|
| `color-palette.json` | 283 KB | Raw color palette (e.g., `blue-500`, `gray-1000`) with light/dark/wireframe sets |
| `color-aliases.json` | 104 KB | Semantic color aliases (e.g., `accent-color`) referencing the palette |
| `color-component.json` | 26 KB | Component-specific color tokens |
| `semantic-color-palette.json` | 23 KB | Semantic groupings of palette colors |
| `typography.json` | 96 KB | Font families, sizes, weights, line heights |
| `layout.json` | 180 KB | Spacing, sizing, radius scale tokens |
| `layout-component.json` | 588 KB | Component-specific layout tokens |
| `icons.json` | 56 KB | Icon metadata |

## Refreshing the snapshot

To track a newer Spectrum release:

1. Pick a commit SHA from
   <https://github.com/adobe/spectrum-design-data/commits/main>.
2. Replace each `.json` in this directory with the version from
   `https://raw.githubusercontent.com/adobe/spectrum-design-data/<NEW_SHA>/packages/tokens/src/<file>.json`.
3. Update the **Commit SHA** and **Date pinned** fields above.
4. Run `swift package generate-tokens` from the repository root.
5. Run `swift test` — the generator-idempotency, traceability, and snapshot tests will
   catch any inconsistencies.
6. Open a PR with the JSON refresh, the regenerated `Tokens/*.swift`, and any updated
   snapshot baselines. Reviewers verify that the visible token diffs match the
   intended Spectrum changes.

## Why pin to a SHA, not a version tag?

Tags can be moved. A SHA cannot. Reproducibility is non-negotiable per
`spec.md` FR-003 (generator idempotency) and FR-005 (snapshot traceability).
