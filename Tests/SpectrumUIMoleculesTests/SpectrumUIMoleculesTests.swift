import XCTest
@testable import SpectrumUIMolecules

final class SpectrumUIMoleculesTests: XCTestCase {
    func testProductIsImportable() {
        XCTAssertEqual(SpectrumUIMolecules.moduleName, "SpectrumUIMolecules")
    }
}
