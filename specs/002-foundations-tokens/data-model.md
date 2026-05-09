# Phase 1 Data Model: Foundations Token System

**Feature**: 002-foundations-tokens
**Date**: 2026-05-09

The "data model" for this feature is the runtime + generation-time shape of the token
system. There are no databases or persisted entities — the values live in generated
Swift source. This document describes the entities, their fields, validation rules, and
relationships.

## Entities

### 1. Token

The atomic unit of design value.

| Field | Type | Description |
|-------|------|-------------|
| `path` | `String` | Full Spectrum identifier, e.g. `color.accent.500`. |
| `category` | `TokenCategory` | One of the eight categories. |
| `swiftIdentifier` | `String` | Generated Swift access path, e.g. `accent.s500`. |
| `valueType` | `TokenValueType` | The Swift type the token resolves to. |
| `lightValue` | `TokenValue` | Resolved value in the `light` theme baseline. |
| `darkValue` | `TokenValue?` | Resolved value in `dark`; `nil` if identical to light. |
| `reducedValue` | `TokenValue?` | For motion tokens, the reduced-motion variant; `nil` for non-motion. |
| `sourceJSONPath` | `String` | Pointer into the snapshot JSON, e.g. `accent-color/accent-color-500/value`. |
| `docComment` | `String` | One-line description from Spectrum's metadata. |

**Validation**:

- `path` MUST be unique within the package.
- `swiftIdentifier` MUST conform to Swift identifier rules; the generator transforms
  numeric tail segments (`500`) into `s500` automatically per R-003.
- `lightValue` and (if present) `darkValue` MUST share the same `valueType`.
- `sourceJSONPath` MUST resolve to a real path in the checked-in snapshot — verified
  by the traceability test (FR-017).
- For `category == .motion`, `reducedValue` SHOULD be present; for other categories,
  it MUST be `nil`.

### 2. TokenCategory (enum)

| Case | Default value type | Notes |
|------|-------------------|-------|
| `.color` | `SpectrumColor` (R-002) | Light/dark-aware |
| `.spacing` | `CGFloat` | Length in points |
| `.typography` | `SpectrumFont` (R-005) | Includes Dynamic Type bridge |
| `.motion` | `SpectrumDuration` | Wraps base + reduced `Duration` |
| `.elevation` | `SpectrumElevation` | Shadow geometry struct |
| `.radius` | `CGFloat` | Length in points |
| `.opacity` | `Double` | 0.0 – 1.0 |
| `.sizing` | `CGFloat` | Length in points |

### 3. Theme

A named rendering context.

| Field | Type | Description |
|-------|------|-------------|
| `name` | `String` | `"light"`, `"dark"`, or a consumer-supplied name. |
| `base` | `BaseTheme` (`light` \| `dark`) | Which built-in theme this customizes. |
| `overrides` | `[TokenIdentifier: TokenValue]` | Sparse map of token-level overrides. |

**Validation**:

- `name` MUST be non-empty.
- For tokens not present in `overrides`, the value resolves from `base`.
- Override `TokenValue` MUST match the original token's `valueType` (compile-time
  enforced by typed key paths in the public API; see contracts).

**Built-ins** (shipped in v0.2.0):

- `Theme.light` — every token resolves to its `lightValue`.
- `Theme.dark` — every token resolves to its `darkValue ?? lightValue`.

### 4. SpectrumColor (public value type)

| Field | Type | Description |
|-------|------|-------------|
| `lightHex` | `UInt32` | sRGB color as 0xAARRGGBB. |
| `darkHex` | `UInt32` | sRGB color as 0xAARRGGBB. |

Conforms to `ShapeStyle` (per R-002). At resolve time, picks `lightHex` or `darkHex`
based on the active `colorScheme`, and applies any theme override.

### 5. SpectrumFont (public value type)

| Field | Type | Description |
|-------|------|-------------|
| `base` | `Font` | Ready-to-apply SwiftUI font. |
| `textStyle` | `Font.TextStyle?` | Anchor for Dynamic Type scaling on iOS. |
| `lineHeight` | `CGFloat?` | Spectrum-specified line height. |
| `tracking` | `CGFloat?` | Spectrum-specified tracking (kerning). |

Applied via a custom `View` extension `.spectrumFont(_:)` that handles the lineHeight +
tracking modifiers SwiftUI doesn't expose directly on `Font`.

### 6. SpectrumDuration (public value type)

| Field | Type | Description |
|-------|------|-------------|
| `base` | `Duration` | The Spectrum-specified duration. |
| `reduced` | `Duration` | The duration to use when reduce-motion is on. |

Resolved via `.resolve(reduceMotion: Bool)`.

### 7. SpectrumElevation (public value type)

| Field | Type | Description |
|-------|------|-------------|
| `xOffset` | `CGFloat` | Shadow x offset. |
| `yOffset` | `CGFloat` | Shadow y offset. |
| `blur` | `CGFloat` | Shadow blur radius. |
| `color` | `SpectrumColor` | Shadow color (theme-aware). |
| `opacity` | `Double` | Shadow opacity. |

### 8. Spectrum JSON Snapshot

A checked-in JSON file at `Tools/SpectrumTokensSnapshot/spectrum-tokens.json`.

| Property | Description |
|----------|-------------|
| Format | The shape Adobe's `@adobe/spectrum-tokens` package publishes. Hierarchical, JSON. |
| Source | Pinned to a specific commit SHA of `github.com/adobe/spectrum-tokens` (per R-008). |
| Authority | The single source of truth for all token values. |

**Validation**:

- Snapshot MUST be valid JSON.
- The generator MUST reject the snapshot if any required category is missing or
  malformed.
- The snapshot's pinned commit SHA MUST be recorded in `Tools/README.md`.

### 9. Generator

The SPM command plugin at `Plugins/GenerateTokens/`.

| Property | Description |
|----------|-------------|
| Invocation | `swift package generate-tokens` |
| Input | `Tools/SpectrumTokensSnapshot/spectrum-tokens.json` |
| Output | Eight files under `Sources/SpectrumUIFoundations/Tokens/` |
| Idempotency | Running twice MUST produce zero diff (FR-003) |

## Relationships

```
SpectrumJSONSnapshot ──input──▶ Generator ──writes──▶ Token (×N)
                                                          │
                                                          ▼
                                          SpectrumUIFoundations module
                                                          │
                                       resolved at view-render time via
                                          ┌──────────────┼──────────────┐
                                          ▼              ▼              ▼
                              EnvironmentValues.colorScheme
                              EnvironmentValues.spectrumTheme   ◀── consumer overrides
                              EnvironmentValues.accessibilityReduceMotion
```

## State Transitions

The token system has two relevant transitions:

### A. Snapshot refresh (maintainer flow)

```
[snapshot vN] ──refresh JSON──▶ [snapshot vN+1] ──run generator──▶ [Tokens/* updated]
                                                                          │
                                                                          ▼
                                                            ── Generator-Idempotency
                                                               check passes (zero diff
                                                               on second run)
                                                            ── Traceability check passes
                                                               (every emitted token's
                                                               sourceJSONPath resolves)
                                                            ── Snapshot tests pass
```

If any of the three checks fails, the refresh PR is blocked.

### B. Adding a new theme (consumer flow)

```
Theme.light ─┐
             ├─▶ consumer constructs Theme(base: .light, overrides: [...])
Theme.dark  ─┘                         │
                                       ▼
                                .spectrumTheme(custom)
                                       │
                                       ▼
                            descendant views resolve overridden tokens
```

No state lives in the library across renders; SwiftUI's `Environment` carries the
current theme through the view tree.
