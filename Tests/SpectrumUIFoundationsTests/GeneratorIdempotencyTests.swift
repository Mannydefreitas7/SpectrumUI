import XCTest

/// Verifies FR-003 / FR-016: token generation is reproducible — running the
/// emit logic twice on the same JSON snapshot produces byte-identical output,
/// and that output matches the checked-in `Tokens/*.swift` files.
///
/// The plugin lives in its own SPM module which test targets can't import, so
/// `GeneratorEmittersForTesting.swift` mirrors its render logic. See that file's
/// header for how drift is caught.
final class GeneratorIdempotencyTests: XCTestCase {

    private func packageRoot() throws -> URL {
        var dir = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
        for _ in 0..<8 {
            if FileManager.default.fileExists(atPath: dir.appendingPathComponent("Package.swift").path) {
                return dir
            }
            dir.deleteLastPathComponent()
        }
        throw XCTSkip("Package root not locatable from test bundle")
    }

    private func snapshotDir() throws -> String {
        try packageRoot().appendingPathComponent("Tools/SpectrumTokensSnapshot").path
    }

    /// FR-003: two back-to-back emits over the same input produce byte-identical output.
    func testEmitIsByteIdenticalAcrossTwoRuns() throws {
        let dir = try snapshotDir()
        guard FileManager.default.fileExists(atPath: dir) else {
            throw XCTSkip("Snapshot directory missing — Tools/ not shipped to this environment")
        }

        let first  = try emitTokenSourcesForTesting(snapshotDir: dir)
        let second = try emitTokenSourcesForTesting(snapshotDir: dir)

        XCTAssertEqual(first.count, second.count, "Emit returned different file counts across runs")
        for (a, b) in zip(first, second) {
            XCTAssertEqual(a.name, b.name, "Filename order diverged across runs")
            XCTAssertEqual(
                a.content, b.content,
                "Content for \(a.name) diverged between two emits — generator is not idempotent"
            )
        }
    }

    /// FR-016: the checked-in `Tokens/*.swift` files match a fresh emit. Catches
    /// hand-edits to generated sources and drift between the plugin and the
    /// test-side render copy.
    func testEmitMatchesCheckedInSources() throws {
        let dir = try snapshotDir()
        guard FileManager.default.fileExists(atPath: dir) else {
            throw XCTSkip("Snapshot directory missing — Tools/ not shipped to this environment")
        }
        let outputDir = try packageRoot().appendingPathComponent("Sources/SpectrumUIFoundations/Tokens")

        let outputs = try emitTokenSourcesForTesting(snapshotDir: dir)

        for (name, expected) in outputs {
            let onDisk = outputDir.appendingPathComponent(name)
            let actual = try String(contentsOf: onDisk, encoding: .utf8)
            XCTAssertEqual(
                actual, expected,
                """
                \(name) on disk does not match a fresh emit.
                Either Tokens/\(name) was hand-edited, or the plugin's render logic
                changed without `GeneratorEmittersForTesting.swift` being updated to match.
                Re-run `swift package generate-tokens --allow-writing-to-package-directory`
                and sync the test-side renderer.
                """
            )
        }
    }
}
