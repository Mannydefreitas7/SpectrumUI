import XCTest
@testable import SpectrumUIFoundations

final class SpectrumUIFoundationsTests: XCTestCase {
    func testProductIsImportable() {
        XCTAssertEqual(SpectrumUIFoundations.moduleName, "SpectrumUIFoundations")
    }
}
