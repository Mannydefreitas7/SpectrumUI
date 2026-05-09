import XCTest
import SpectrumUI

final class SpectrumUITests: XCTestCase {
    func testUmbrellaReExportsEveryAtomicProduct() {
        XCTAssertEqual(SpectrumUIFoundations.moduleName, "SpectrumUIFoundations")
        XCTAssertEqual(SpectrumUIIcons.moduleName, "SpectrumUIIcons")
        XCTAssertEqual(SpectrumUIAtoms.moduleName, "SpectrumUIAtoms")
        XCTAssertEqual(SpectrumUIMolecules.moduleName, "SpectrumUIMolecules")
    }
}
