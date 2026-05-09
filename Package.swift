// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SpectrumUI",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(name: "SpectrumUIFoundations", targets: ["SpectrumUIFoundations"]),
        .library(name: "SpectrumUIIcons", targets: ["SpectrumUIIcons"]),
        .library(name: "SpectrumUIAtoms", targets: ["SpectrumUIAtoms"]),
        .library(name: "SpectrumUIMolecules", targets: ["SpectrumUIMolecules"]),
        .library(name: "SpectrumUI", targets: ["SpectrumUI"]),
        .plugin(name: "GenerateTokens", targets: ["GenerateTokens"])
    ],
    dependencies: [
        // Test-only: snapshot testing for token rendering.
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.15.0"
        )
    ],
    targets: [
        // MARK: Foundations — bottom of the stack; zero internal dependencies.
        .target(
            name: "SpectrumUIFoundations",
            dependencies: []
        ),
        .testTarget(
            name: "SpectrumUIFoundationsTests",
            dependencies: [
                "SpectrumUIFoundations",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        ),

        // MARK: Icons — depends only on Foundations.
        .target(
            name: "SpectrumUIIcons",
            dependencies: ["SpectrumUIFoundations"]
        ),
        .testTarget(
            name: "SpectrumUIIconsTests",
            dependencies: ["SpectrumUIIcons"]
        ),

        // MARK: Atoms — depends only on Foundations.
        .target(
            name: "SpectrumUIAtoms",
            dependencies: ["SpectrumUIFoundations"]
        ),
        .testTarget(
            name: "SpectrumUIAtomsTests",
            dependencies: ["SpectrumUIAtoms"]
        ),

        // MARK: Molecules — composes Foundations + Icons + Atoms.
        .target(
            name: "SpectrumUIMolecules",
            dependencies: [
                "SpectrumUIFoundations",
                "SpectrumUIIcons",
                "SpectrumUIAtoms"
            ]
        ),
        .testTarget(
            name: "SpectrumUIMoleculesTests",
            dependencies: ["SpectrumUIMolecules"]
        ),

        // MARK: SpectrumUI (umbrella) — re-exports every atomic layer.
        .target(
            name: "SpectrumUI",
            dependencies: [
                "SpectrumUIFoundations",
                "SpectrumUIIcons",
                "SpectrumUIAtoms",
                "SpectrumUIMolecules"
            ]
        ),
        .testTarget(
            name: "SpectrumUITests",
            dependencies: ["SpectrumUI"]
        ),

        // MARK: GenerateTokens — SPM command plugin.
        // Reads Tools/SpectrumTokensSnapshot/*.json and emits Swift source files
        // into Sources/SpectrumUIFoundations/Tokens/. Run via:
        //   swift package generate-tokens
        .plugin(
            name: "GenerateTokens",
            capability: .command(
                intent: .custom(
                    verb: "generate-tokens",
                    description: "Regenerate SpectrumUIFoundations token sources from the checked-in Adobe Spectrum JSON snapshot."
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "Writes generated token sources into Sources/SpectrumUIFoundations/Tokens/.")
                ]
            )
        )
    ]
)
