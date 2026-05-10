import Foundation

// =============================================================================
// IN-PROCESS COPY OF THE TOKEN-GENERATOR RENDER LOGIC.
//
// SPM command plugins live in their own module and cannot be imported by test
// targets, so this file mirrors the pure render functions from
// `Plugins/GenerateTokens/GenerateTokens.swift` verbatim. Tests call
// `emitTokenSourcesForTesting(snapshotDir:)` here to exercise the same emit
// behavior the plugin uses.
//
// Drift between the two copies is caught by
// `GeneratorIdempotencyTests.testEmitMatchesCheckedInSources`: it compares this
// file's output against the on-disk `Tokens/*.swift` files (which the plugin
// produced). If they diverge, one of the two sides was edited without syncing
// the other — fix by mirroring the change here.
//
// KEEP THIS FILE BYTE-EQUIVALENT (modulo identifier suffixes and this header)
// TO `Plugins/GenerateTokens/GenerateTokens.swift`.
// =============================================================================

func emitTokenSourcesForTesting(snapshotDir: String) throws -> [(name: String, content: String)] {
    let palette = try loadJSONDictForTesting(at: "\(snapshotDir)/color-palette.json")
    let layout  = try loadJSONDictForTesting(at: "\(snapshotDir)/layout.json")

    return [
        ("ColorPaletteTokens.swift", renderColorPaletteForTesting(palette)),
        ("SpacingTokens.swift", renderDimensionTokensForTesting(
            from: layout,
            prefix: "spacing-",
            structName: "SpacingTokens",
            docComment: "Spacing scale tokens (`CGFloat`, in points). Use for padding, gaps, and inset distances. Higher numbers = more space."
        )),
        ("RadiusTokens.swift", renderDimensionTokensForTesting(
            from: layout,
            prefix: "corner-radius-",
            structName: "RadiusTokens",
            docComment: "Corner-radius tokens (`CGFloat`, in points)."
        ))
    ]
}

func loadJSONDictForTesting(at path: String) throws -> [String: Any] {
    let url = URL(fileURLWithPath: path)
    let data = try Data(contentsOf: url)
    guard let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
        throw GeneratorTestError.malformedJSON(path)
    }
    return dict
}

enum GeneratorTestError: Error, CustomStringConvertible {
    case malformedJSON(String)
    var description: String {
        switch self {
        case .malformedJSON(let p): return "Malformed JSON at \(p)"
        }
    }
}

// MARK: - rgb()/rgba() parser (mirror of plugin's parseRGBHex)

func parseRGBHexForTesting(_ s: String) -> UInt32? {
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

func parsePxToCGFloatForTesting(_ s: String) -> Double? {
    let trimmed = s.trimmingCharacters(in: .whitespaces)
    if trimmed.hasSuffix("px"), let n = Double(trimmed.dropLast(2)) { return n }
    if let n = Double(trimmed) { return n }
    return nil
}

// MARK: - Header banner

private let generatedBannerForTesting = """
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

func renderColorPaletteForTesting(_ palette: [String: Any]) -> String {
    var families: [String: [(scale: Int, light: UInt32, dark: UInt32)]] = [:]

    for (name, raw) in palette {
        guard let token = raw as? [String: Any],
              let sets = token["sets"] as? [String: Any],
              let lightSet = sets["light"] as? [String: Any],
              let darkSet  = sets["dark"]  as? [String: Any],
              let lightVal = lightSet["value"] as? String,
              let darkVal  = darkSet["value"]  as? String,
              let lightHex = parseRGBHexForTesting(lightVal),
              let darkHex  = parseRGBHexForTesting(darkVal)
        else { continue }

        guard let dash = name.lastIndex(of: "-"),
              let scale = Int(name[name.index(after: dash)...])
        else { continue }
        let family = String(name[..<dash])

        families[family, default: []].append((scale, lightHex, darkHex))
    }

    var out = generatedBannerForTesting + "\n\nimport SwiftUI\n\n"

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

func renderDimensionTokensForTesting(
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
              let pt = parsePxToCGFloatForTesting(value)
        else { continue }

        let suffix = String(name.dropFirst(prefix.count))
        guard let scale = Int(suffix) else { continue }
        pairs.append((scale, pt, name))
    }

    pairs.sort { $0.scale < $1.scale }

    var out = generatedBannerForTesting + "\n\nimport SwiftUI\n\n"
    out += "/// \(docComment)\n"
    out += "public struct \(structName): Sendable {\n"
    out += "    public init() {}\n\n"
    for entry in pairs {
        out += "    /// `\(entry.name)` — `layout.json/\(entry.name)` (\(formatPtForTesting(entry.value)) pt)\n"
        out += "    public var s\(entry.scale): CGFloat { \(formatPtForTesting(entry.value)) }\n"
    }
    out += "}\n"
    return out
}

private func formatPtForTesting(_ v: Double) -> String {
    if v == v.rounded() {
        return String(Int(v))
    }
    return String(format: "%g", v)
}
