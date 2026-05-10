import XCTest
import SpectrumUIFoundations

/// Verifies FR-017: every generated token's source-JSON-path comment must resolve to
/// a real key in the checked-in Spectrum JSON snapshot.
///
/// We do this without parsing Swift source — the SpectrumColor's `id` field carries
/// the token's source path. We sample a handful of generated palette tokens and
/// confirm each `id` is a key in the corresponding JSON file.
final class TraceabilityTests: XCTestCase {

    // MARK: Locate the snapshot

    /// Walks up from the test bundle to find the package root (where `Package.swift`
    /// lives), then locates the JSON snapshot directory. Avoids hardcoding paths
    /// that would break if the test target moves.
    private func snapshotDir() throws -> URL {
        var dir = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
        for _ in 0..<8 {
            let candidate = dir.appendingPathComponent("Tools/SpectrumTokensSnapshot")
            if FileManager.default.fileExists(atPath: candidate.path) {
                return candidate
            }
            dir.deleteLastPathComponent()
        }
        throw XCTSkip("Snapshot directory not locatable from test bundle (CI environments may not ship Tools/).")
    }

    private func loadJSON(_ name: String) throws -> [String: Any] {
        let url = try snapshotDir().appendingPathComponent(name)
        let data = try Data(contentsOf: url)
        guard let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            XCTFail("Malformed JSON: \(name)"); return [:]
        }
        return dict
    }

    // MARK: Tests

    func testPaletteTokenIDsResolveInColorPaletteJSON() throws {
        let palette = try loadJSON("color-palette.json")

        // Sample tokens spanning different families and scales.
        let samples: [SpectrumColor] = [
            Spectrum.color.palette.blue.s500,
            Spectrum.color.palette.gray.s1000,
            Spectrum.color.palette.red.s700,
            Spectrum.color.palette.green.s700,
            Spectrum.color.palette.purple.s900
        ]

        for c in samples {
            guard let id = c.id else {
                XCTFail("Generated palette tokens must carry an id"); continue
            }
            XCTAssertNotNil(palette[id],
                "Token id '\(id)' is not a key in color-palette.json — traceability broken")
        }
    }

    func testGeneratorOutputCarriesGeneratedBanner() throws {
        var dir = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
        for _ in 0..<8 {
            let candidate = dir.appendingPathComponent(
                "Sources/SpectrumUIFoundations/Tokens/ColorPaletteTokens.swift")
            if FileManager.default.fileExists(atPath: candidate.path) {
                let content = try String(contentsOf: candidate, encoding: .utf8)
                XCTAssertTrue(
                    content.contains("GENERATED — DO NOT EDIT"),
                    "ColorPaletteTokens.swift must carry the generator banner"
                )
                return
            }
            dir.deleteLastPathComponent()
        }
        throw XCTSkip("ColorPaletteTokens.swift not locatable from test bundle")
    }
}
