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
        .library(name: "SpectrumUI", targets: ["SpectrumUI"])
    ],
    targets: [
        // MARK: Foundations — bottom of the stack; zero internal dependencies.
        .target(
            name: "SpectrumUIFoundations",
            dependencies: []
        ),
        .testTarget(
            name: "SpectrumUIFoundationsTests",
            dependencies: ["SpectrumUIFoundations"]
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
        )
    ]
)
