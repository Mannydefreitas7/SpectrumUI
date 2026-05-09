import XCTest
import SpectrumUIAtoms

final class SpectrumUIAtomsTests: XCTestCase {
    func testProductIsImportable() {
        XCTAssertEqual(SpectrumUIAtoms.moduleName, "SpectrumUIAtoms")
    }
}
