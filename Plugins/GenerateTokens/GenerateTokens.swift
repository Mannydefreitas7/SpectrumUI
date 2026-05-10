import Foundation
import PackagePlugin

/// SPM command plugin: regenerate SpectrumUIFoundations token sources from the
/// checked-in Adobe Spectrum JSON snapshot.
///
/// Run with:
///
/// ```bash
/// swift package generate-tokens --allow-writing-to-package-directory
/// ```
///
/// **Scope (v0.2.x):** Generates the categories Adobe ships in a generator-friendly
/// shape — color palette (`color-palette.json`) and dimension layout tokens
/// (`layout.json`'s `spacing-*` and `corner-radius-*`). The remaining four
/// categories — typography, motion, elevation, opacity, and sizing — are not in
/// `@adobe/spectrum-tokens` in a directly-renderable form (typography is atomic;
/// motion/elevation/opacity/sizing aren't published) and remain hand-curated.
@main
struct GenerateTokens: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let packageRoot = context.package.directory.string
        let snapshotDir = packageRoot + "/Tools/SpectrumTokensSnapshot"
        let outputDir   = packageRoot + "/Sources/SpectrumUIFoundations/Tokens"

        Diagnostics.remark("""
        SpectrumUIFoundations token generator
        ═════════════════════════════════════
        Snapshot: \(snapshotDir)
        Output:   \(outputDir)
        """)

        let palette = try loadJSON(at: "\(snapshotDir)/color-palette.json")
        let layout  = try loadJSON(at: "\(snapshotDir)/layout.json")

        let paletteFile  = renderColorPalette(palette)
        let spacingFile  = renderDimensionTokens(
            from: layout,
            prefix: "spacing-",
            structName: "SpacingTokens",
            docComment: "Spacing scale tokens (`CGFloat`, in points). Use for padding, gaps, and inset distances. Higher numbers = more space."
        )
        let radiusFile   = renderDimensionTokens(
            from: layout,
            prefix: "corner-radius-",
            structName: "RadiusTokens",
            docComment: "Corner-radius tokens (`CGFloat`, in points)."
        )

        try write(paletteFile, to: "\(outputDir)/ColorPaletteTokens.swift")
        try write(spacingFile, to: "\(outputDir)/SpacingTokens.swift")
        try write(radiusFile,  to: "\(outputDir)/RadiusTokens.swift")

        Diagnostics.remark("""
        ✓ ColorPaletteTokens.swift  (\(paletteFile.count) bytes)
        ✓ SpacingTokens.swift       (\(spacingFile.count) bytes)
        ✓ RadiusTokens.swift        (\(radiusFile.count) bytes)
        Other categories (typography/motion/elevation/opacity/sizing/semantic-color)
        remain hand-curated in this release — see headers in each file.
        """)
    }

    // MARK: JSON loader

    private func loadJSON(at path: String) throws -> [String: Any] {
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)
        guard let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw GeneratorError.malformedJSON(path)
        }
        return dict
    }

    private func write(_ content: String, to path: String) throws {
        try content.write(toFile: path, atomically: true, encoding: .utf8)
    }
}

// MARK: - Errors

enum GeneratorError: Error, CustomStringConvertible {
    case malformedJSON(String)
    case unparseableValue(String, String)

    var description: String {
        switch self {
        case .malformedJSON(let path):
            return "Malformed JSON at \(path)"
        case .unparseableValue(let token, let value):
            return "Cannot parse value for \(token): \(value)"
        }
    }
}

// MARK: - rgb()/rgba() parser

func parseRGBHex(_ s: String) -> UInt32? {
    // Matches rgb(R, G, B) or rgba(R, G, B, A) where A is 0.0–1.0 or a percentage.
    let trimmed = s.trimmingCharacters(in: .whitespaces)
    guard trimmed.hasPrefix("rgb(") || trimmed.hasPrefix("rgba(") else { return nil }
    let inside = trimmed
        .replacingOccurrences(of: "rgba(", with: "")
        .replacingOccurrences(of: "rgb(", with: "")
        .replacingOccurrences(of: ")", with: "")
    let parts = inside.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
    guard parts.count >= 3,
          let r = UInt32(parts[0]), r <= 255,
          let g = UInt32(parts[1]), g <= 255,
          let b = UInt32(parts[2]), b <= 255
    else { return nil }
    var a: UInt32 = 0xFF
    if parts.count >= 4, let alphaFloat = Double(parts[3]) {
        a = UInt32(min(1.0, max(0.0, alphaFloat)) * 255.0)
    }
    return (a << 24) | (r << 16) | (g << 8) | b
}

func parsePxToCGFloat(_ s: String) -> Double? {
    let trimmed = s.trimmingCharacters(in: .whitespaces)
    if trimmed.hasSuffix("px"), let n = Double(trimmed.dropLast(2)) { return n }
    if let n = Double(trimmed) { return n }
    return nil
}

// MARK: - Header banner

private let generatedBanner = """
// ============================================================================
// GENERATED — DO NOT EDIT.
//
// Produced by the GenerateTokens SPM command plugin from the Adobe Spectrum JSON
// snapshot at Tools/SpectrumTokensSnapshot/. To refresh, follow the instructions
// in Tools/SpectrumTokensSnapshot/README.md and re-run:
//   swift package generate-tokens --allow-writing-to-package-directory
// ============================================================================
"""

// MARK: - Color palette emitter

func renderColorPalette(_ palette: [String: Any]) -> String {
    // Group "blue-500" → family="blue", scale=500. Skip tokens without 'sets'.
    var families: [String: [(scale: Int, light: UInt32, dark: UInt32)]] = [:]

    for (name, raw) in palette {
        guard let token = raw as? [String: Any],
              let sets = token["sets"] as? [String: Any],
              let lightSet = sets["light"] as? [String: Any],
              let darkSet  = sets["dark"]  as? [String: Any],
              let lightVal = lightSet["value"] as? String,
              let darkVal  = darkSet["value"]  as? String,
              let lightHex = parseRGBHex(lightVal),
              let darkHex  = parseRGBHex(darkVal)
        else { continue }

        // Parse "<family>-<scale>" — only emit canonical numeric scales.
        guard let dash = name.lastIndex(of: "-"),
              let scale = Int(name[name.index(after: dash)...])
        else { continue }
        let family = String(name[..<dash])

        families[family, default: []].append((scale, lightHex, darkHex))
    }

    var out = generatedBanner + "\n\nimport SwiftUI\n\n"

    out += """
    /// Adobe Spectrum's full color palette. Reachable via `Spectrum.color.palette`.
    ///
    /// Token paths follow the form `Spectrum.color.palette.<family>.s<N>` where
    /// `<family>` is one of the \(families.count) Spectrum color families and `<N>` is
    /// the published scale step.
    public extension ColorTokens {
        var palette: ColorPalette { ColorPalette() }
    }

    /// Color palette namespace — generated from `color-palette.json`.
    public struct ColorPalette: Sendable {
        public init() {}


    """

    for family in families.keys.sorted() {
        let cap = family.prefix(1).uppercased() + family.dropFirst()
        out += "    public var \(family): \(cap)PaletteColors { \(cap)PaletteColors() }\n"
    }
    out += "}\n\n"

    for family in families.keys.sorted() {
        let cap = family.prefix(1).uppercased() + family.dropFirst()
        out += "/// `\(family)` family — \(families[family]!.count) shades from `color-palette.json`.\n"
        out += "public struct \(cap)PaletteColors: Sendable {\n"
        out += "    public init() {}\n"
        for entry in families[family]!.sorted(by: { $0.scale < $1.scale }) {
            let lightStr = String(format: "0x%08X", entry.light)
            let darkStr  = String(format: "0x%08X", entry.dark)
            out += "    /// `\(family)-\(entry.scale)` — `color-palette.json/\(family)-\(entry.scale)`\n"
            out += "    public var s\(entry.scale): SpectrumColor {\n"
            out += "        SpectrumColor(id: \"\(family)-\(entry.scale)\", lightHex: \(lightStr), darkHex: \(darkStr))\n"
            out += "    }\n"
        }
        out += "}\n\n"
    }

    return out
}

// MARK: - Dimension emitter (spacing, corner-radius)

func renderDimensionTokens(
    from layout: [String: Any],
    prefix: String,
    structName: String,
    docComment: String
) -> String {
    var pairs: [(scale: Int, value: Double, name: String)] = []

    for (name, raw) in layout {
        guard name.hasPrefix(prefix),
              let token = raw as? [String: Any],
              let value = token["value"] as? String,
              let pt = parsePxToCGFloat(value)
        else { continue }

        // "spacing-100" → 100. Treat "spacing-25" as 25.
        let suffix = String(name.dropFirst(prefix.count))
        guard let scale = Int(suffix) else { continue }
        pairs.append((scale, pt, name))
    }

    pairs.sort { $0.scale < $1.scale }

    var out = generatedBanner + "\n\nimport SwiftUI\n\n"
    out += "/// \(docComment)\n"
    out += "public struct \(structName): Sendable {\n"
    out += "    public init() {}\n\n"
    for entry in pairs {
        out += "    /// `\(entry.name)` — `layout.json/\(entry.name)` (\(formatPt(entry.value)) pt)\n"
        out += "    public var s\(entry.scale): CGFloat { \(formatPt(entry.value)) }\n"
    }
    out += "}\n"
    return out
}

private func formatPt(_ v: Double) -> String {
    if v == v.rounded() {
        return String(Int(v))
    }
    return String(format: "%g", v)
}
