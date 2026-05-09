import Foundation
import PackagePlugin

/// SPM command plugin: regenerate SpectrumUIFoundations token sources from the
/// checked-in Adobe Spectrum JSON snapshot.
///
/// **v0.2.0 status: scaffolded.** The plugin entry point and JSON loader are wired
/// up, but the per-category emitters that turn parsed tokens into Swift source are
/// not yet implemented. v0.2.0 ships a hand-curated subset of tokens (see
/// `Sources/SpectrumUIFoundations/Tokens/*.swift` headers); v0.2.1 will replace
/// those files with this plugin's output covering Spectrum's full token catalog.
///
/// Run with:
///
/// ```bash
/// swift package generate-tokens
/// ```
///
/// In v0.2.0, the plugin verifies the snapshot is present and reachable, lists the
/// JSON files, and exits — the actual emit step is gated until the per-category
/// emitters land.
@main
struct GenerateTokens: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let packageRoot = context.package.directory.string

        let snapshotDir = packageRoot + "/Tools/SpectrumTokensSnapshot"
        let snapshotURL = URL(fileURLWithPath: snapshotDir)

        guard FileManager.default.fileExists(atPath: snapshotDir) else {
            Diagnostics.error("Snapshot directory missing: \(snapshotDir)")
            return
        }

        let files = try FileManager.default
            .contentsOfDirectory(at: snapshotURL, includingPropertiesForKeys: nil)
            .filter { $0.pathExtension == "json" }
            .sorted { $0.lastPathComponent < $1.lastPathComponent }

        Diagnostics.remark("""
        SpectrumUIFoundations token generator (v0.2.0 scaffold)
        ═══════════════════════════════════════════════════════
        Snapshot directory: \(snapshotDir)
        JSON files found:   \(files.count)
        """)

        for url in files {
            let attrs = try FileManager.default.attributesOfItem(atPath: url.path)
            let size = (attrs[.size] as? Int) ?? 0
            Diagnostics.remark("  • \(url.lastPathComponent) (\(size) bytes)")
        }

        Diagnostics.warning("""
        Per-category emit step is not yet implemented in v0.2.0. Token source files
        in Sources/SpectrumUIFoundations/Tokens/ are hand-curated for this release.
        Full generation arrives in v0.2.1.
        """)
    }
}
