/// Root namespace for the Molecules layer of SpectrumUI.
///
/// Molecules exposes composed components built from one or more atoms (SearchField,
/// Card, Toast, and the like). It depends on `SpectrumUIFoundations`,
/// `SpectrumUIIcons`, and `SpectrumUIAtoms`. Consumers can import Molecules without
/// also importing the lower layers — the package graph pulls them in automatically.
public enum SpectrumUIMolecules {
    /// Stable string identifier for this product. Useful in diagnostics and tests.
    public static let moduleName = "SpectrumUIMolecules"
}
