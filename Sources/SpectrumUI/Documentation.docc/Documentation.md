# ``SpectrumUI``

The umbrella product for SpectrumUI: a single import that re-exports every atomic layer.

## Overview

`SpectrumUI` re-exports `SpectrumUIFoundations`, `SpectrumUIIcons`, `SpectrumUIAtoms`, and `SpectrumUIMolecules`. Use it when you want the full library with one import:

```swift
import SpectrumUI
```

If you only need a single layer (for example, just the design tokens), depend on that atomic product directly to keep your binary lean.

The umbrella has no behavioral surface of its own; it is a pure re-export.
