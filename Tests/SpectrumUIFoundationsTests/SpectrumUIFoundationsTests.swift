import XCTest
import SpectrumUIFoundations

final class SpectrumUIFoundationsTests: XCTestCase {
    func testProductIsImportable() {
        XCTAssertEqual(SpectrumUIFoundations.moduleName, "SpectrumUIFoundations")
    }
}
