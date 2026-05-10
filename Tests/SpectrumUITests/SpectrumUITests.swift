import XCTest
import SpectrumUI

final class SpectrumUITests: XCTestCase {
    func testUmbrellaReExportsEveryAtomicProduct() {
        // Foundations dropped its moduleName constant in v0.2.0 (replaced by the real
        // token system); proving Foundations is reachable is now done via the Spectrum
        // namespace.
        _ = Spectrum.color
        _ = Theme.light

        // The other three atomic products still ship a moduleName marker until their
        // own real surfaces land.
        XCTAssertEqual(SpectrumUIIcons.moduleName, "SpectrumUIIcons")
        XCTAssertEqual(SpectrumUIAtoms.moduleName, "SpectrumUIAtoms")
        XCTAssertEqual(SpectrumUIMolecules.moduleName, "SpectrumUIMolecules")
    }
}
