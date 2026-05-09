/// Umbrella module that re-exports every atomic SpectrumUI layer.
///
/// Importing `SpectrumUI` brings `SpectrumUIFoundations`, `SpectrumUIIcons`,
/// `SpectrumUIAtoms`, and `SpectrumUIMolecules` symbols into scope through a
/// single `import SpectrumUI` statement. Use this when you want the full library;
/// otherwise depend directly on the atomic products you need to keep your binary lean.
///
/// The re-exports use Swift's `@_exported import` attribute. The leading underscore
/// indicates it has not been formally accepted by Swift Evolution, but it is the
/// standard idiom for umbrella modules and is used by Apple's own packages.
@_exported import SpectrumUIFoundations
@_exported import SpectrumUIIcons
@_exported import SpectrumUIAtoms
@_exported import SpectrumUIMolecules
