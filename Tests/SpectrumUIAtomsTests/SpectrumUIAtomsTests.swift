import XCTest
@testable import SpectrumUIAtoms

final class SpectrumUIAtomsTests: XCTestCase {
    func testProductIsImportable() {
        XCTAssertEqual(SpectrumUIAtoms.moduleName, "SpectrumUIAtoms")
    }
}
