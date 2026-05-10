// ============================================================================
// GENERATED — DO NOT EDIT.
//
// Produced by the GenerateTokens SPM command plugin from the Adobe Spectrum JSON
// snapshot at Tools/SpectrumTokensSnapshot/. To refresh, follow the instructions
// in Tools/SpectrumTokensSnapshot/README.md and re-run:
//   swift package generate-tokens --allow-writing-to-package-directory
// ============================================================================

import SwiftUI

/// Adobe Spectrum's full color palette. Reachable via `Spectrum.color.palette`.
///
/// Token paths follow the form `Spectrum.color.palette.<family>.s<N>` where
/// `<family>` is one of the 19 Spectrum color families and `<N>` is
/// the published scale step.
public extension ColorTokens {
    var palette: ColorPalette { ColorPalette() }
}

/// Color palette namespace — generated from `color-palette.json`.
public struct ColorPalette: Sendable {
    public init() {}

    public var blue: BluePaletteColors { BluePaletteColors() }
    public var brown: BrownPaletteColors { BrownPaletteColors() }
    public var celery: CeleryPaletteColors { CeleryPaletteColors() }
    public var chartreuse: ChartreusePaletteColors { ChartreusePaletteColors() }
    public var cinnamon: CinnamonPaletteColors { CinnamonPaletteColors() }
    public var cyan: CyanPaletteColors { CyanPaletteColors() }
    public var fuchsia: FuchsiaPaletteColors { FuchsiaPaletteColors() }
    public var gray: GrayPaletteColors { GrayPaletteColors() }
    public var green: GreenPaletteColors { GreenPaletteColors() }
    public var indigo: IndigoPaletteColors { IndigoPaletteColors() }
    public var magenta: MagentaPaletteColors { MagentaPaletteColors() }
    public var orange: OrangePaletteColors { OrangePaletteColors() }
    public var pink: PinkPaletteColors { PinkPaletteColors() }
    public var purple: PurplePaletteColors { PurplePaletteColors() }
    public var red: RedPaletteColors { RedPaletteColors() }
    public var seafoam: SeafoamPaletteColors { SeafoamPaletteColors() }
    public var silver: SilverPaletteColors { SilverPaletteColors() }
    public var turquoise: TurquoisePaletteColors { TurquoisePaletteColors() }
    public var yellow: YellowPaletteColors { YellowPaletteColors() }
}

/// `blue` family — 16 shades from `color-palette.json`.
public struct BluePaletteColors: Sendable {
    public init() {}
    /// `blue-100` — `color-palette.json/blue-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "blue-100", lightHex: 0xFFF5F9FF, darkHex: 0xFF0E173F)
    }
    /// `blue-200` — `color-palette.json/blue-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "blue-200", lightHex: 0xFFE5F0FE, darkHex: 0xFF0F1C52)
    }
    /// `blue-300` — `color-palette.json/blue-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "blue-300", lightHex: 0xFFCBE2FE, darkHex: 0xFF0C2175)
    }
    /// `blue-400` — `color-palette.json/blue-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "blue-400", lightHex: 0xFFACCFFD, darkHex: 0xFF122D9A)
    }
    /// `blue-500` — `color-palette.json/blue-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "blue-500", lightHex: 0xFF8EB9FC, darkHex: 0xFF1A3AC3)
    }
    /// `blue-600` — `color-palette.json/blue-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "blue-600", lightHex: 0xFF729EFD, darkHex: 0xFF2549E5)
    }
    /// `blue-700` — `color-palette.json/blue-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "blue-700", lightHex: 0xFF5D89FF, darkHex: 0xFF345BF8)
    }
    /// `blue-800` — `color-palette.json/blue-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "blue-800", lightHex: 0xFF4B75FF, darkHex: 0xFF4069FD)
    }
    /// `blue-900` — `color-palette.json/blue-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "blue-900", lightHex: 0xFF3B63FB, darkHex: 0xFF5681FF)
    }
    /// `blue-1000` — `color-palette.json/blue-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "blue-1000", lightHex: 0xFF274DEA, darkHex: 0xFF6995FE)
    }
    /// `blue-1100` — `color-palette.json/blue-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "blue-1100", lightHex: 0xFF1D3ECF, darkHex: 0xFF7CA9FC)
    }
    /// `blue-1200` — `color-palette.json/blue-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "blue-1200", lightHex: 0xFF1532AD, darkHex: 0xFF98C0FC)
    }
    /// `blue-1300` — `color-palette.json/blue-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "blue-1300", lightHex: 0xFF10288C, darkHex: 0xFFB5D5FD)
    }
    /// `blue-1400` — `color-palette.json/blue-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "blue-1400", lightHex: 0xFF0C1F69, darkHex: 0xFFD5E7FE)
    }
    /// `blue-1500` — `color-palette.json/blue-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "blue-1500", lightHex: 0xFF0E1843, darkHex: 0xFFEEF5FF)
    }
    /// `blue-1600` — `color-palette.json/blue-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "blue-1600", lightHex: 0xFF070B1E, darkHex: 0xFFFFFFFF)
    }
}

/// `brown` family — 16 shades from `color-palette.json`.
public struct BrownPaletteColors: Sendable {
    public init() {}
    /// `brown-100` — `color-palette.json/brown-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "brown-100", lightHex: 0xFFFCF7F2, darkHex: 0xFF231808)
    }
    /// `brown-200` — `color-palette.json/brown-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "brown-200", lightHex: 0xFFF7EEE1, darkHex: 0xFF2C1F0B)
    }
    /// `brown-300` — `color-palette.json/brown-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "brown-300", lightHex: 0xFFEFDDC3, darkHex: 0xFF3A280E)
    }
    /// `brown-400` — `color-palette.json/brown-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "brown-400", lightHex: 0xFFE5C89D, darkHex: 0xFF4E3713)
    }
    /// `brown-500` — `color-palette.json/brown-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "brown-500", lightHex: 0xFFD6B17B, darkHex: 0xFF62471E)
    }
    /// `brown-600` — `color-palette.json/brown-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "brown-600", lightHex: 0xFFBE9B68, darkHex: 0xFF73582F)
    }
    /// `brown-700` — `color-palette.json/brown-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "brown-700", lightHex: 0xFFAB8A5A, darkHex: 0xFF84683D)
    }
    /// `brown-800` — `color-palette.json/brown-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "brown-800", lightHex: 0xFF9A7B4D, darkHex: 0xFF8F7245)
    }
    /// `brown-900` — `color-palette.json/brown-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "brown-900", lightHex: 0xFF8B6D42, darkHex: 0xFFA38454)
    }
    /// `brown-1000` — `color-palette.json/brown-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "brown-1000", lightHex: 0xFF775B32, darkHex: 0xFFB59362)
    }
    /// `brown-1100` — `color-palette.json/brown-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "brown-1100", lightHex: 0xFF674C23, darkHex: 0xFFC7A370)
    }
    /// `brown-1200` — `color-palette.json/brown-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "brown-1200", lightHex: 0xFF583D15, darkHex: 0xFFDEB982)
    }
    /// `brown-1300` — `color-palette.json/brown-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "brown-1300", lightHex: 0xFF463111, darkHex: 0xFFE8CFA9)
    }
    /// `brown-1400` — `color-palette.json/brown-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "brown-1400", lightHex: 0xFF34250D, darkHex: 0xFFF2E3CE)
    }
    /// `brown-1500` — `color-palette.json/brown-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "brown-1500", lightHex: 0xFF261A09, darkHex: 0xFFFAF4EC)
    }
    /// `brown-1600` — `color-palette.json/brown-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "brown-1600", lightHex: 0xFF100C04, darkHex: 0xFFFFFFFF)
    }
}

/// `celery` family — 16 shades from `color-palette.json`.
public struct CeleryPaletteColors: Sendable {
    public init() {}
    /// `celery-100` — `color-palette.json/celery-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "celery-100", lightHex: 0xFFEBFFDC, darkHex: 0xFF0B1F00)
    }
    /// `celery-200` — `color-palette.json/celery-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "celery-200", lightHex: 0xFFC5FF9C, darkHex: 0xFF0F2600)
    }
    /// `celery-300` — `color-palette.json/celery-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "celery-300", lightHex: 0xFF9DF75C, darkHex: 0xFF153301)
    }
    /// `celery-400` — `color-palette.json/celery-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "celery-400", lightHex: 0xFF81E43A, darkHex: 0xFF1F4304)
    }
    /// `celery-500` — `color-palette.json/celery-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "celery-500", lightHex: 0xFF6ECE2A, darkHex: 0xFF295608)
    }
    /// `celery-600` — `color-palette.json/celery-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "celery-600", lightHex: 0xFF5DB41F, darkHex: 0xFF32690B)
    }
    /// `celery-700` — `color-palette.json/celery-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "celery-700", lightHex: 0xFF52A119, darkHex: 0xFF3C7A0F)
    }
    /// `celery-800` — `color-palette.json/celery-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "celery-800", lightHex: 0xFF489014, darkHex: 0xFF428612)
    }
    /// `celery-900` — `color-palette.json/celery-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "celery-900", lightHex: 0xFF408111, darkHex: 0xFF4E9A17)
    }
    /// `celery-1000` — `color-palette.json/celery-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "celery-1000", lightHex: 0xFF346D0C, darkHex: 0xFF58AC1C)
    }
    /// `celery-1100` — `color-palette.json/celery-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "celery-1100", lightHex: 0xFF2C5C09, darkHex: 0xFF64BE23)
    }
    /// `celery-1200` — `color-palette.json/celery-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "celery-1200", lightHex: 0xFF234B06, darkHex: 0xFF74D52E)
    }
    /// `celery-1300` — `color-palette.json/celery-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "celery-1300", lightHex: 0xFF1B3C03, darkHex: 0xFF88EA41)
    }
    /// `celery-1400` — `color-palette.json/celery-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "celery-1400", lightHex: 0xFF132E00, darkHex: 0xFFAAFB70)
    }
    /// `celery-1500` — `color-palette.json/celery-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "celery-1500", lightHex: 0xFF0C2100, darkHex: 0xFFDEFFC6)
    }
    /// `celery-1600` — `color-palette.json/celery-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "celery-1600", lightHex: 0xFF040F00, darkHex: 0xFFFFFFFF)
    }
}

/// `chartreuse` family — 16 shades from `color-palette.json`.
public struct ChartreusePaletteColors: Sendable {
    public init() {}
    /// `chartreuse-100` — `color-palette.json/chartreuse-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "chartreuse-100", lightHex: 0xFFF6FBDE, darkHex: 0xFF171C00)
    }
    /// `chartreuse-200` — `color-palette.json/chartreuse-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "chartreuse-200", lightHex: 0xFFEAF6AD, darkHex: 0xFF1E2400)
    }
    /// `chartreuse-300` — `color-palette.json/chartreuse-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "chartreuse-300", lightHex: 0xFFD0EC46, darkHex: 0xFF272F00)
    }
    /// `chartreuse-400` — `color-palette.json/chartreuse-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "chartreuse-400", lightHex: 0xFFB6DB00, darkHex: 0xFF353F00)
    }
    /// `chartreuse-500` — `color-palette.json/chartreuse-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "chartreuse-500", lightHex: 0xFFA3C400, darkHex: 0xFF445200)
    }
    /// `chartreuse-600` — `color-palette.json/chartreuse-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "chartreuse-600", lightHex: 0xFF8FAC00, darkHex: 0xFF536400)
    }
    /// `chartreuse-700` — `color-palette.json/chartreuse-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "chartreuse-700", lightHex: 0xFF809900, darkHex: 0xFF617400)
    }
    /// `chartreuse-800` — `color-palette.json/chartreuse-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "chartreuse-800", lightHex: 0xFF728900, darkHex: 0xFF6A7F00)
    }
    /// `chartreuse-900` — `color-palette.json/chartreuse-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "chartreuse-900", lightHex: 0xFF667A00, darkHex: 0xFF7A9300)
    }
    /// `chartreuse-1000` — `color-palette.json/chartreuse-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "chartreuse-1000", lightHex: 0xFF566700, darkHex: 0xFF88A400)
    }
    /// `chartreuse-1100` — `color-palette.json/chartreuse-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "chartreuse-1100", lightHex: 0xFF495700, darkHex: 0xFF97B500)
    }
    /// `chartreuse-1200` — `color-palette.json/chartreuse-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "chartreuse-1200", lightHex: 0xFF3C4700, darkHex: 0xFFA9CB00)
    }
    /// `chartreuse-1300` — `color-palette.json/chartreuse-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "chartreuse-1300", lightHex: 0xFF2F3900, darkHex: 0xFFBBE100)
    }
    /// `chartreuse-1400` — `color-palette.json/chartreuse-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "chartreuse-1400", lightHex: 0xFF232B00, darkHex: 0xFFDBF075)
    }
    /// `chartreuse-1500` — `color-palette.json/chartreuse-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "chartreuse-1500", lightHex: 0xFF191E00, darkHex: 0xFFF2F9CE)
    }
    /// `chartreuse-1600` — `color-palette.json/chartreuse-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "chartreuse-1600", lightHex: 0xFF0B0E00, darkHex: 0xFFFFFFFF)
    }
}

/// `cinnamon` family — 16 shades from `color-palette.json`.
public struct CinnamonPaletteColors: Sendable {
    public init() {}
    /// `cinnamon-100` — `color-palette.json/cinnamon-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "cinnamon-100", lightHex: 0xFFFDF7F3, darkHex: 0xFF301104)
    }
    /// `cinnamon-200` — `color-palette.json/cinnamon-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "cinnamon-200", lightHex: 0xFFF9ECE5, darkHex: 0xFF3B1505)
    }
    /// `cinnamon-300` — `color-palette.json/cinnamon-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "cinnamon-300", lightHex: 0xFFF4DACB, darkHex: 0xFF4F1C07)
    }
    /// `cinnamon-400` — `color-palette.json/cinnamon-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "cinnamon-400", lightHex: 0xFFEDC4AC, darkHex: 0xFF64290F)
    }
    /// `cinnamon-500` — `color-palette.json/cinnamon-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "cinnamon-500", lightHex: 0xFFE5AA88, darkHex: 0xFF7A391C)
    }
    /// `cinnamon-600` — `color-palette.json/cinnamon-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "cinnamon-600", lightHex: 0xFFD4916C, darkHex: 0xFF8F4A28)
    }
    /// `cinnamon-700` — `color-palette.json/cinnamon-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "cinnamon-700", lightHex: 0xFFC67E58, darkHex: 0xFFA35834)
    }
    /// `cinnamon-800` — `color-palette.json/cinnamon-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "cinnamon-800", lightHex: 0xFFB86D46, darkHex: 0xFFB0623B)
    }
    /// `cinnamon-900` — `color-palette.json/cinnamon-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "cinnamon-900", lightHex: 0xFFAA5E38, darkHex: 0xFFC07750)
    }
    /// `cinnamon-1000` — `color-palette.json/cinnamon-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "cinnamon-1000", lightHex: 0xFF934D2B, darkHex: 0xFFCE8863)
    }
    /// `cinnamon-1100` — `color-palette.json/cinnamon-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "cinnamon-1100", lightHex: 0xFF803E20, darkHex: 0xFFDC9A76)
    }
    /// `cinnamon-1200` — `color-palette.json/cinnamon-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "cinnamon-1200", lightHex: 0xFF6E3015, darkHex: 0xFFE8B395)
    }
    /// `cinnamon-1300` — `color-palette.json/cinnamon-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "cinnamon-1300", lightHex: 0xFF5C230B, darkHex: 0xFFEFCBB7)
    }
    /// `cinnamon-1400` — `color-palette.json/cinnamon-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "cinnamon-1400", lightHex: 0xFF481906, darkHex: 0xFFF6E1D6)
    }
    /// `cinnamon-1500` — `color-palette.json/cinnamon-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "cinnamon-1500", lightHex: 0xFF341204, darkHex: 0xFFFCF4EF)
    }
    /// `cinnamon-1600` — `color-palette.json/cinnamon-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "cinnamon-1600", lightHex: 0xFF180802, darkHex: 0xFFFFFFFF)
    }
}

/// `cyan` family — 16 shades from `color-palette.json`.
public struct CyanPaletteColors: Sendable {
    public init() {}
    /// `cyan-100` — `color-palette.json/cyan-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "cyan-100", lightHex: 0xFFEEFAFE, darkHex: 0xFF001D27)
    }
    /// `cyan-200` — `color-palette.json/cyan-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "cyan-200", lightHex: 0xFFD9F4FD, darkHex: 0xFF002431)
    }
    /// `cyan-300` — `color-palette.json/cyan-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "cyan-300", lightHex: 0xFFB7E7FC, darkHex: 0xFF003041)
    }
    /// `cyan-400` — `color-palette.json/cyan-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "cyan-400", lightHex: 0xFF8AD5FF, darkHex: 0xFF004058)
    }
    /// `cyan-500` — `color-palette.json/cyan-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "cyan-500", lightHex: 0xFF5CC0FF, darkHex: 0xFF005271)
    }
    /// `cyan-600` — `color-palette.json/cyan-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "cyan-600", lightHex: 0xFF30A7FE, darkHex: 0xFF03638C)
    }
    /// `cyan-700` — `color-palette.json/cyan-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "cyan-700", lightHex: 0xFF1D95E7, darkHex: 0xFF0873A8)
    }
    /// `cyan-800` — `color-palette.json/cyan-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "cyan-800", lightHex: 0xFF1286CD, darkHex: 0xFF0D7DBA)
    }
    /// `cyan-900` — `color-palette.json/cyan-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "cyan-900", lightHex: 0xFF0B78B3, darkHex: 0xFF188EDC)
    }
    /// `cyan-1000` — `color-palette.json/cyan-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "cyan-1000", lightHex: 0xFF046691, darkHex: 0xFF269FF4)
    }
    /// `cyan-1100` — `color-palette.json/cyan-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "cyan-1100", lightHex: 0xFF005779, darkHex: 0xFF3FB1FF)
    }
    /// `cyan-1200` — `color-palette.json/cyan-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "cyan-1200", lightHex: 0xFF004762, darkHex: 0xFF6BC7FF)
    }
    /// `cyan-1300` — `color-palette.json/cyan-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "cyan-1300", lightHex: 0xFF00394E, darkHex: 0xFF98DBFF)
    }
    /// `cyan-1400` — `color-palette.json/cyan-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "cyan-1400", lightHex: 0xFF002B3B, darkHex: 0xFFC3ECFC)
    }
    /// `cyan-1500` — `color-palette.json/cyan-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "cyan-1500", lightHex: 0xFF001F2B, darkHex: 0xFFE6F8FD)
    }
    /// `cyan-1600` — `color-palette.json/cyan-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "cyan-1600", lightHex: 0xFF000E14, darkHex: 0xFFFFFFFF)
    }
}

/// `fuchsia` family — 16 shades from `color-palette.json`.
public struct FuchsiaPaletteColors: Sendable {
    public init() {}
    /// `fuchsia-100` — `color-palette.json/fuchsia-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "fuchsia-100", lightHex: 0xFFFEF6FF, darkHex: 0xFF32003D)
    }
    /// `fuchsia-200` — `color-palette.json/fuchsia-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "fuchsia-200", lightHex: 0xFFFDE9FF, darkHex: 0xFF3D004A)
    }
    /// `fuchsia-300` — `color-palette.json/fuchsia-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "fuchsia-300", lightHex: 0xFFFAD3FF, darkHex: 0xFF4F005F)
    }
    /// `fuchsia-400` — `color-palette.json/fuchsia-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "fuchsia-400", lightHex: 0xFFF7B5FF, darkHex: 0xFF660978)
    }
    /// `fuchsia-500` — `color-palette.json/fuchsia-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "fuchsia-500", lightHex: 0xFFF393FF, darkHex: 0xFF7F1792)
    }
    /// `fuchsia-600` — `color-palette.json/fuchsia-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "fuchsia-600", lightHex: 0xFFEC69FF, darkHex: 0xFF9726AA)
    }
    /// `fuchsia-700` — `color-palette.json/fuchsia-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "fuchsia-700", lightHex: 0xFFDF4DF5, darkHex: 0xFFAD33C0)
    }
    /// `fuchsia-800` — `color-palette.json/fuchsia-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "fuchsia-800", lightHex: 0xFFC844DC, darkHex: 0xFFBA3CCE)
    }
    /// `fuchsia-900` — `color-palette.json/fuchsia-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "fuchsia-900", lightHex: 0xFFB539C8, darkHex: 0xFFD549EB)
    }
    /// `fuchsia-1000` — `color-palette.json/fuchsia-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "fuchsia-1000", lightHex: 0xFF9C28AF, darkHex: 0xFFE85BFD)
    }
    /// `fuchsia-1100` — `color-palette.json/fuchsia-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "fuchsia-1100", lightHex: 0xFF871B9A, darkHex: 0xFFF07AFF)
    }
    /// `fuchsia-1200` — `color-palette.json/fuchsia-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "fuchsia-1200", lightHex: 0xFF710F83, darkHex: 0xFFF59FFF)
    }
    /// `fuchsia-1300` — `color-palette.json/fuchsia-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "fuchsia-1300", lightHex: 0xFF5C046D, darkHex: 0xFFF8BFFF)
    }
    /// `fuchsia-1400` — `color-palette.json/fuchsia-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "fuchsia-1400", lightHex: 0xFF480058, darkHex: 0xFFFBDBFF)
    }
    /// `fuchsia-1500` — `color-palette.json/fuchsia-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "fuchsia-1500", lightHex: 0xFF360042, darkHex: 0xFFFDF1FF)
    }
    /// `fuchsia-1600` — `color-palette.json/fuchsia-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "fuchsia-1600", lightHex: 0xFF1D0023, darkHex: 0xFFFFFFFF)
    }
}

/// `gray` family — 13 shades from `color-palette.json`.
public struct GrayPaletteColors: Sendable {
    public init() {}
    /// `gray-25` — `color-palette.json/gray-25`
    public var s25: SpectrumColor {
        SpectrumColor(id: "gray-25", lightHex: 0xFFFFFFFF, darkHex: 0xFF111111)
    }
    /// `gray-50` — `color-palette.json/gray-50`
    public var s50: SpectrumColor {
        SpectrumColor(id: "gray-50", lightHex: 0xFFF8F8F8, darkHex: 0xFF1B1B1B)
    }
    /// `gray-75` — `color-palette.json/gray-75`
    public var s75: SpectrumColor {
        SpectrumColor(id: "gray-75", lightHex: 0xFFF3F3F3, darkHex: 0xFF222222)
    }
    /// `gray-100` — `color-palette.json/gray-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "gray-100", lightHex: 0xFFE9E9E9, darkHex: 0xFF2C2C2C)
    }
    /// `gray-200` — `color-palette.json/gray-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "gray-200", lightHex: 0xFFE1E1E1, darkHex: 0xFF323232)
    }
    /// `gray-300` — `color-palette.json/gray-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "gray-300", lightHex: 0xFFDADADA, darkHex: 0xFF393939)
    }
    /// `gray-400` — `color-palette.json/gray-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "gray-400", lightHex: 0xFFC6C6C6, darkHex: 0xFF444444)
    }
    /// `gray-500` — `color-palette.json/gray-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "gray-500", lightHex: 0xFF8F8F8F, darkHex: 0xFF6D6D6D)
    }
    /// `gray-600` — `color-palette.json/gray-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "gray-600", lightHex: 0xFF717171, darkHex: 0xFF8A8A8A)
    }
    /// `gray-700` — `color-palette.json/gray-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "gray-700", lightHex: 0xFF505050, darkHex: 0xFFAFAFAF)
    }
    /// `gray-800` — `color-palette.json/gray-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "gray-800", lightHex: 0xFF292929, darkHex: 0xFFDBDBDB)
    }
    /// `gray-900` — `color-palette.json/gray-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "gray-900", lightHex: 0xFF131313, darkHex: 0xFFF2F2F2)
    }
    /// `gray-1000` — `color-palette.json/gray-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "gray-1000", lightHex: 0xFF000000, darkHex: 0xFFFFFFFF)
    }
}

/// `green` family — 16 shades from `color-palette.json`.
public struct GreenPaletteColors: Sendable {
    public init() {}
    /// `green-100` — `color-palette.json/green-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "green-100", lightHex: 0xFFEDFCF1, darkHex: 0xFF001E17)
    }
    /// `green-200` — `color-palette.json/green-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "green-200", lightHex: 0xFFD7F7E1, darkHex: 0xFF00261D)
    }
    /// `green-300` — `color-palette.json/green-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "green-300", lightHex: 0xFFADEEC5, darkHex: 0xFF003326)
    }
    /// `green-400` — `color-palette.json/green-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "green-400", lightHex: 0xFF6BE3A2, darkHex: 0xFF004430)
    }
    /// `green-500` — `color-palette.json/green-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "green-500", lightHex: 0xFF2BD17D, darkHex: 0xFF02573A)
    }
    /// `green-600` — `color-palette.json/green-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "green-600", lightHex: 0xFF12B867, darkHex: 0xFF036A43)
    }
    /// `green-700` — `color-palette.json/green-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "green-700", lightHex: 0xFF0BA45D, darkHex: 0xFF047C4B)
    }
    /// `green-800` — `color-palette.json/green-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "green-800", lightHex: 0xFF079355, darkHex: 0xFF068850)
    }
    /// `green-900` — `color-palette.json/green-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "green-900", lightHex: 0xFF05834E, darkHex: 0xFF099D59)
    }
    /// `green-1000` — `color-palette.json/green-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "green-1000", lightHex: 0xFF036E45, darkHex: 0xFF0EAF62)
    }
    /// `green-1100` — `color-palette.json/green-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "green-1100", lightHex: 0xFF025D3C, darkHex: 0xFF18C16E)
    }
    /// `green-1200` — `color-palette.json/green-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "green-1200", lightHex: 0xFF014C34, darkHex: 0xFF39D786)
    }
    /// `green-1300` — `color-palette.json/green-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "green-1300", lightHex: 0xFF003D2C, darkHex: 0xFF7EE7AC)
    }
    /// `green-1400` — `color-palette.json/green-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "green-1400", lightHex: 0xFF002E22, darkHex: 0xFFBDF1D0)
    }
    /// `green-1500` — `color-palette.json/green-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "green-1500", lightHex: 0xFF002119, darkHex: 0xFFE5FAEC)
    }
    /// `green-1600` — `color-palette.json/green-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "green-1600", lightHex: 0xFF000F0C, darkHex: 0xFFFFFFFF)
    }
}

/// `indigo` family — 16 shades from `color-palette.json`.
public struct IndigoPaletteColors: Sendable {
    public init() {}
    /// `indigo-100` — `color-palette.json/indigo-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "indigo-100", lightHex: 0xFFF7F8FF, darkHex: 0xFF1E005D)
    }
    /// `indigo-200` — `color-palette.json/indigo-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "indigo-200", lightHex: 0xFFEBEEFF, darkHex: 0xFF23006E)
    }
    /// `indigo-300` — `color-palette.json/indigo-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "indigo-300", lightHex: 0xFFD8DEFF, darkHex: 0xFF2F008C)
    }
    /// `indigo-400` — `color-palette.json/indigo-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "indigo-400", lightHex: 0xFFC0C9FF, darkHex: 0xFF3E0CAE)
    }
    /// `indigo-500` — `color-palette.json/indigo-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "indigo-500", lightHex: 0xFFA7B2FF, darkHex: 0xFF4F1ED1)
    }
    /// `indigo-600` — `color-palette.json/indigo-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "indigo-600", lightHex: 0xFF9197FE, darkHex: 0xFF5F34EB)
    }
    /// `indigo-700` — `color-palette.json/indigo-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "indigo-700", lightHex: 0xFF8480FE, darkHex: 0xFF6D4BF8)
    }
    /// `indigo-800` — `color-palette.json/indigo-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "indigo-800", lightHex: 0xFF7A6AFD, darkHex: 0xFF745BFC)
    }
    /// `indigo-900` — `color-palette.json/indigo-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "indigo-900", lightHex: 0xFF7155FA, darkHex: 0xFF8077FE)
    }
    /// `indigo-1000` — `color-palette.json/indigo-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "indigo-1000", lightHex: 0xFF6338EE, darkHex: 0xFF8B8DFE)
    }
    /// `indigo-1100` — `color-palette.json/indigo-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "indigo-1100", lightHex: 0xFF5424DB, darkHex: 0xFF99A1FF)
    }
    /// `indigo-1200` — `color-palette.json/indigo-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "indigo-1200", lightHex: 0xFF4513BF, darkHex: 0xFFB0BAFF)
    }
    /// `indigo-1300` — `color-palette.json/indigo-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "indigo-1300", lightHex: 0xFF3706A0, darkHex: 0xFFC7D0FF)
    }
    /// `indigo-1400` — `color-palette.json/indigo-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "indigo-1400", lightHex: 0xFF2A0081, darkHex: 0xFFDFE4FF)
    }
    /// `indigo-1500` — `color-palette.json/indigo-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "indigo-1500", lightHex: 0xFF1F0062, darkHex: 0xFFF3F4FF)
    }
    /// `indigo-1600` — `color-palette.json/indigo-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "indigo-1600", lightHex: 0xFF110036, darkHex: 0xFFFFFFFF)
    }
}

/// `magenta` family — 16 shades from `color-palette.json`.
public struct MagentaPaletteColors: Sendable {
    public init() {}
    /// `magenta-100` — `color-palette.json/magenta-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "magenta-100", lightHex: 0xFFFFF5F8, darkHex: 0xFF3B0016)
    }
    /// `magenta-200` — `color-palette.json/magenta-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "magenta-200", lightHex: 0xFFFFE8F0, darkHex: 0xFF4A001B)
    }
    /// `magenta-300` — `color-palette.json/magenta-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "magenta-300", lightHex: 0xFFFFD5E3, darkHex: 0xFF5D0022)
    }
    /// `magenta-400` — `color-palette.json/magenta-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "magenta-400", lightHex: 0xFFFFB9D0, darkHex: 0xFF7B002D)
    }
    /// `magenta-500` — `color-palette.json/magenta-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "magenta-500", lightHex: 0xFFFF98BB, darkHex: 0xFF98073C)
    }
    /// `magenta-600` — `color-palette.json/magenta-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "magenta-600", lightHex: 0xFFFF709F, darkHex: 0xFFB5134C)
    }
    /// `magenta-700` — `color-palette.json/magenta-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "magenta-700", lightHex: 0xFFFF4885, darkHex: 0xFFCF1F5C)
    }
    /// `magenta-800` — `color-palette.json/magenta-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "magenta-800", lightHex: 0xFFF02D6E, darkHex: 0xFFE02665)
    }
    /// `magenta-900` — `color-palette.json/magenta-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "magenta-900", lightHex: 0xFFD92361, darkHex: 0xFFFF3377)
    }
    /// `magenta-1000` — `color-palette.json/magenta-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "magenta-1000", lightHex: 0xFFBA1650, darkHex: 0xFFFF6095)
    }
    /// `magenta-1100` — `color-palette.json/magenta-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "magenta-1100", lightHex: 0xFFA3053E, darkHex: 0xFFFF80AB)
    }
    /// `magenta-1200` — `color-palette.json/magenta-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "magenta-1200", lightHex: 0xFF880033, darkHex: 0xFFFFA3C2)
    }
    /// `magenta-1300` — `color-palette.json/magenta-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "magenta-1300", lightHex: 0xFF6F0028, darkHex: 0xFFFFC1D6)
    }
    /// `magenta-1400` — `color-palette.json/magenta-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "magenta-1400", lightHex: 0xFF56001E, darkHex: 0xFFFFDCE8)
    }
    /// `magenta-1500` — `color-palette.json/magenta-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "magenta-1500", lightHex: 0xFF400016, darkHex: 0xFFFFF1F6)
    }
    /// `magenta-1600` — `color-palette.json/magenta-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "magenta-1600", lightHex: 0xFF23000C, darkHex: 0xFFFFFFFF)
    }
}

/// `orange` family — 16 shades from `color-palette.json`.
public struct OrangePaletteColors: Sendable {
    public init() {}
    /// `orange-100` — `color-palette.json/orange-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "orange-100", lightHex: 0xFFFFF6E7, darkHex: 0xFF311000)
    }
    /// `orange-200` — `color-palette.json/orange-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "orange-200", lightHex: 0xFFFFECCF, darkHex: 0xFF3D1500)
    }
    /// `orange-300` — `color-palette.json/orange-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "orange-300", lightHex: 0xFFFFDA9E, darkHex: 0xFF501B00)
    }
    /// `orange-400` — `color-palette.json/orange-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "orange-400", lightHex: 0xFFFFC15E, darkHex: 0xFF6A2400)
    }
    /// `orange-500` — `color-palette.json/orange-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "orange-500", lightHex: 0xFFFFA213, darkHex: 0xFF872F00)
    }
    /// `orange-600` — `color-palette.json/orange-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "orange-600", lightHex: 0xFFFC7D00, darkHex: 0xFFA23B00)
    }
    /// `orange-700` — `color-palette.json/orange-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "orange-700", lightHex: 0xFFE86A00, darkHex: 0xFFB94900)
    }
    /// `orange-800` — `color-palette.json/orange-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "orange-800", lightHex: 0xFFD45B00, darkHex: 0xFFC75200)
    }
    /// `orange-900` — `color-palette.json/orange-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "orange-900", lightHex: 0xFFC24E00, darkHex: 0xFFE06400)
    }
    /// `orange-1000` — `color-palette.json/orange-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "orange-1000", lightHex: 0xFFA73E00, darkHex: 0xFFF37500)
    }
    /// `orange-1100` — `color-palette.json/orange-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "orange-1100", lightHex: 0xFF903300, darkHex: 0xFFFF8900)
    }
    /// `orange-1200` — `color-palette.json/orange-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "orange-1200", lightHex: 0xFF762900, darkHex: 0xFFFFAD2D)
    }
    /// `orange-1300` — `color-palette.json/orange-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "orange-1300", lightHex: 0xFF5F2000, darkHex: 0xFFFFC974)
    }
    /// `orange-1400` — `color-palette.json/orange-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "orange-1400", lightHex: 0xFF491800, darkHex: 0xFFFFE1B2)
    }
    /// `orange-1500` — `color-palette.json/orange-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "orange-1500", lightHex: 0xFF341200, darkHex: 0xFFFFF3E1)
    }
    /// `orange-1600` — `color-palette.json/orange-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "orange-1600", lightHex: 0xFF190800, darkHex: 0xFFFFFFFF)
    }
}

/// `pink` family — 16 shades from `color-palette.json`.
public struct PinkPaletteColors: Sendable {
    public init() {}
    /// `pink-100` — `color-palette.json/pink-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "pink-100", lightHex: 0xFFFFF6FC, darkHex: 0xFF3A0025)
    }
    /// `pink-200` — `color-palette.json/pink-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "pink-200", lightHex: 0xFFFFE8F7, darkHex: 0xFF47002C)
    }
    /// `pink-300` — `color-palette.json/pink-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "pink-300", lightHex: 0xFFFFD3F0, darkHex: 0xFF5A0039)
    }
    /// `pink-400` — `color-palette.json/pink-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "pink-400", lightHex: 0xFFFFB5E6, darkHex: 0xFF73074B)
    }
    /// `pink-500` — `color-palette.json/pink-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "pink-500", lightHex: 0xFFFF94DB, darkHex: 0xFF8F1261)
    }
    /// `pink-600` — `color-palette.json/pink-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "pink-600", lightHex: 0xFFFF67CC, darkHex: 0xFFAB1D77)
    }
    /// `pink-700` — `color-palette.json/pink-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "pink-700", lightHex: 0xFFF24CB8, darkHex: 0xFFC4278A)
    }
    /// `pink-800` — `color-palette.json/pink-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "pink-800", lightHex: 0xFFE434A3, darkHex: 0xFFD52D97)
    }
    /// `pink-900` — `color-palette.json/pink-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "pink-900", lightHex: 0xFFCE2A92, darkHex: 0xFFEC43AF)
    }
    /// `pink-1000` — `color-palette.json/pink-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "pink-1000", lightHex: 0xFFB01F7B, darkHex: 0xFFFB5AC4)
    }
    /// `pink-1100` — `color-palette.json/pink-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "pink-1100", lightHex: 0xFF981668, darkHex: 0xFFFF7AD2)
    }
    /// `pink-1200` — `color-palette.json/pink-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "pink-1200", lightHex: 0xFF800C55, darkHex: 0xFFFF9FDF)
    }
    /// `pink-1300` — `color-palette.json/pink-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "pink-1300", lightHex: 0xFF690344, darkHex: 0xFFFFBFEA)
    }
    /// `pink-1400` — `color-palette.json/pink-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "pink-1400", lightHex: 0xFF530035, darkHex: 0xFFFFDBF3)
    }
    /// `pink-1500` — `color-palette.json/pink-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "pink-1500", lightHex: 0xFF3E0027, darkHex: 0xFFFFF1FA)
    }
    /// `pink-1600` — `color-palette.json/pink-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "pink-1600", lightHex: 0xFF210015, darkHex: 0xFFFFFFFF)
    }
}

/// `purple` family — 16 shades from `color-palette.json`.
public struct PurplePaletteColors: Sendable {
    public init() {}
    /// `purple-100` — `color-palette.json/purple-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "purple-100", lightHex: 0xFFFBF7FE, darkHex: 0xFF29004F)
    }
    /// `purple-200` — `color-palette.json/purple-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "purple-200", lightHex: 0xFFF4EBFC, darkHex: 0xFF320060)
    }
    /// `purple-300` — `color-palette.json/purple-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "purple-300", lightHex: 0xFFEBDAF9, darkHex: 0xFF40007A)
    }
    /// `purple-400` — `color-palette.json/purple-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "purple-400", lightHex: 0xFFDDC1F6, darkHex: 0xFF53009F)
    }
    /// `purple-500` — `color-palette.json/purple-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "purple-500", lightHex: 0xFFD0A7F3, darkHex: 0xFF6B06C3)
    }
    /// `purple-600` — `color-palette.json/purple-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "purple-600", lightHex: 0xFFBF8AEE, darkHex: 0xFF8222D7)
    }
    /// `purple-700` — `color-palette.json/purple-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "purple-700", lightHex: 0xFFB272EB, darkHex: 0xFF943EE0)
    }
    /// `purple-800` — `color-palette.json/purple-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "purple-800", lightHex: 0xFFA65CE7, darkHex: 0xFF9D4EE4)
    }
    /// `purple-900` — `color-palette.json/purple-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "purple-900", lightHex: 0xFF9A47E2, darkHex: 0xFFAD69E9)
    }
    /// `purple-1000` — `color-palette.json/purple-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "purple-1000", lightHex: 0xFF8628D9, darkHex: 0xFFBA7FED)
    }
    /// `purple-1100` — `color-palette.json/purple-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "purple-1100", lightHex: 0xFF730DCC, darkHex: 0xFFC595F0)
    }
    /// `purple-1200` — `color-palette.json/purple-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "purple-1200", lightHex: 0xFF5D00B1, darkHex: 0xFFD4B0F4)
    }
    /// `purple-1300` — `color-palette.json/purple-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "purple-1300", lightHex: 0xFF4B0090, darkHex: 0xFFE1C9F7)
    }
    /// `purple-1400` — `color-palette.json/purple-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "purple-1400", lightHex: 0xFF3B006F, darkHex: 0xFFEEE0FA)
    }
    /// `purple-1500` — `color-palette.json/purple-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "purple-1500", lightHex: 0xFF2C0054, darkHex: 0xFFF8F3FD)
    }
    /// `purple-1600` — `color-palette.json/purple-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "purple-1600", lightHex: 0xFF17002D, darkHex: 0xFFFFFFFF)
    }
}

/// `red` family — 16 shades from `color-palette.json`.
public struct RedPaletteColors: Sendable {
    public init() {}
    /// `red-100` — `color-palette.json/red-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "red-100", lightHex: 0xFFFFF6F5, darkHex: 0xFF360A03)
    }
    /// `red-200` — `color-palette.json/red-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "red-200", lightHex: 0xFFFFEBE8, darkHex: 0xFF440D05)
    }
    /// `red-300` — `color-palette.json/red-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "red-300", lightHex: 0xFFFFD6D1, darkHex: 0xFF571107)
    }
    /// `red-400` — `color-palette.json/red-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "red-400", lightHex: 0xFFFFBCB4, darkHex: 0xFF73180B)
    }
    /// `red-500` — `color-palette.json/red-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "red-500", lightHex: 0xFFFF9D91, darkHex: 0xFF931F11)
    }
    /// `red-600` — `color-palette.json/red-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "red-600", lightHex: 0xFFFF7665, darkHex: 0xFFB12617)
    }
    /// `red-700` — `color-palette.json/red-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "red-700", lightHex: 0xFFFF513D, darkHex: 0xFFCD2E1D)
    }
    /// `red-800` — `color-palette.json/red-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "red-800", lightHex: 0xFFF03823, darkHex: 0xFFDF3422)
    }
    /// `red-900` — `color-palette.json/red-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "red-900", lightHex: 0xFFD73220, darkHex: 0xFFFC432E)
    }
    /// `red-1000` — `color-palette.json/red-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "red-1000", lightHex: 0xFFB72818, darkHex: 0xFFFF6756)
    }
    /// `red-1100` — `color-palette.json/red-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "red-1100", lightHex: 0xFF9C2113, darkHex: 0xFFFF8678)
    }
    /// `red-1200` — `color-palette.json/red-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "red-1200", lightHex: 0xFF811B0E, darkHex: 0xFFFFA79D)
    }
    /// `red-1300` — `color-palette.json/red-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "red-1300", lightHex: 0xFF68150A, darkHex: 0xFFFFC4BD)
    }
    /// `red-1400` — `color-palette.json/red-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "red-1400", lightHex: 0xFF501006, darkHex: 0xFFFFDEDB)
    }
    /// `red-1500` — `color-palette.json/red-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "red-1500", lightHex: 0xFF3B0B04, darkHex: 0xFFFFF2F0)
    }
    /// `red-1600` — `color-palette.json/red-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "red-1600", lightHex: 0xFF1D0502, darkHex: 0xFFFFFFFF)
    }
}

/// `seafoam` family — 16 shades from `color-palette.json`.
public struct SeafoamPaletteColors: Sendable {
    public init() {}
    /// `seafoam-100` — `color-palette.json/seafoam-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "seafoam-100", lightHex: 0xFFEBFBF6, darkHex: 0xFF001E1B)
    }
    /// `seafoam-200` — `color-palette.json/seafoam-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "seafoam-200", lightHex: 0xFFD3F6EA, darkHex: 0xFF002723)
    }
    /// `seafoam-300` — `color-palette.json/seafoam-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "seafoam-300", lightHex: 0xFFA9EDD8, darkHex: 0xFF00322C)
    }
    /// `seafoam-400` — `color-palette.json/seafoam-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "seafoam-400", lightHex: 0xFF5CE1C2, darkHex: 0xFF00433B)
    }
    /// `seafoam-500` — `color-palette.json/seafoam-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "seafoam-500", lightHex: 0xFF10CFA9, darkHex: 0xFF02564B)
    }
    /// `seafoam-600` — `color-palette.json/seafoam-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "seafoam-600", lightHex: 0xFF0DB595, darkHex: 0xFF046959)
    }
    /// `seafoam-700` — `color-palette.json/seafoam-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "seafoam-700", lightHex: 0xFF0BA286, darkHex: 0xFF067A67)
    }
    /// `seafoam-800` — `color-palette.json/seafoam-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "seafoam-800", lightHex: 0xFF099078, darkHex: 0xFF088670)
    }
    /// `seafoam-900` — `color-palette.json/seafoam-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "seafoam-900", lightHex: 0xFF07816D, darkHex: 0xFF0A9A80)
    }
    /// `seafoam-1000` — `color-palette.json/seafoam-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "seafoam-1000", lightHex: 0xFF056C5C, darkHex: 0xFF0CAD8E)
    }
    /// `seafoam-1100` — `color-palette.json/seafoam-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "seafoam-1100", lightHex: 0xFF035C50, darkHex: 0xFF0EBE9C)
    }
    /// `seafoam-1200` — `color-palette.json/seafoam-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "seafoam-1200", lightHex: 0xFF014B43, darkHex: 0xFF1DD6B0)
    }
    /// `seafoam-1300` — `color-palette.json/seafoam-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "seafoam-1300", lightHex: 0xFF003C36, darkHex: 0xFF7AE5CB)
    }
    /// `seafoam-1400` — `color-palette.json/seafoam-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "seafoam-1400", lightHex: 0xFF002E28, darkHex: 0xFFBAF1DE)
    }
    /// `seafoam-1500` — `color-palette.json/seafoam-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "seafoam-1500", lightHex: 0xFF00211D, darkHex: 0xFFE5F9F3)
    }
    /// `seafoam-1600` — `color-palette.json/seafoam-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "seafoam-1600", lightHex: 0xFF000F0E, darkHex: 0xFFFFFFFF)
    }
}

/// `silver` family — 16 shades from `color-palette.json`.
public struct SilverPaletteColors: Sendable {
    public init() {}
    /// `silver-100` — `color-palette.json/silver-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "silver-100", lightHex: 0xFFF7F7F7, darkHex: 0xFF1A1A1A)
    }
    /// `silver-200` — `color-palette.json/silver-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "silver-200", lightHex: 0xFFEFEFEF, darkHex: 0xFF212121)
    }
    /// `silver-300` — `color-palette.json/silver-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "silver-300", lightHex: 0xFFDFDFDF, darkHex: 0xFF2C2C2C)
    }
    /// `silver-400` — `color-palette.json/silver-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "silver-400", lightHex: 0xFFCCCCCC, darkHex: 0xFF3B3B3B)
    }
    /// `silver-500` — `color-palette.json/silver-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "silver-500", lightHex: 0xFFB7B7B7, darkHex: 0xFF4C4C4C)
    }
    /// `silver-600` — `color-palette.json/silver-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "silver-600", lightHex: 0xFFA0A0A0, darkHex: 0xFF5C5C5C)
    }
    /// `silver-700` — `color-palette.json/silver-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "silver-700", lightHex: 0xFF8F8F8F, darkHex: 0xFF6C6C6C)
    }
    /// `silver-800` — `color-palette.json/silver-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "silver-800", lightHex: 0xFF808080, darkHex: 0xFF767676)
    }
    /// `silver-900` — `color-palette.json/silver-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "silver-900", lightHex: 0xFF727272, darkHex: 0xFF898989)
    }
    /// `silver-1000` — `color-palette.json/silver-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "silver-1000", lightHex: 0xFF606060, darkHex: 0xFF989898)
    }
    /// `silver-1100` — `color-palette.json/silver-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "silver-1100", lightHex: 0xFF515151, darkHex: 0xFFA9A9A9)
    }
    /// `silver-1200` — `color-palette.json/silver-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "silver-1200", lightHex: 0xFF424242, darkHex: 0xFFBEBEBE)
    }
    /// `silver-1300` — `color-palette.json/silver-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "silver-1300", lightHex: 0xFF343434, darkHex: 0xFFD3D3D3)
    }
    /// `silver-1400` — `color-palette.json/silver-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "silver-1400", lightHex: 0xFF272727, darkHex: 0xFFE5E5E5)
    }
    /// `silver-1500` — `color-palette.json/silver-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "silver-1500", lightHex: 0xFF1C1C1C, darkHex: 0xFFF4F4F4)
    }
    /// `silver-1600` — `color-palette.json/silver-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "silver-1600", lightHex: 0xFF0C0C0C, darkHex: 0xFFFFFFFF)
    }
}

/// `turquoise` family — 16 shades from `color-palette.json`.
public struct TurquoisePaletteColors: Sendable {
    public init() {}
    /// `turquoise-100` — `color-palette.json/turquoise-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "turquoise-100", lightHex: 0xFFEEFBFB, darkHex: 0xFF001E21)
    }
    /// `turquoise-200` — `color-palette.json/turquoise-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "turquoise-200", lightHex: 0xFFD1F5F5, darkHex: 0xFF002529)
    }
    /// `turquoise-300` — `color-palette.json/turquoise-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "turquoise-300", lightHex: 0xFFA9ECED, darkHex: 0xFF003136)
    }
    /// `turquoise-400` — `color-palette.json/turquoise-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "turquoise-400", lightHex: 0xFF6FDDE4, darkHex: 0xFF004248)
    }
    /// `turquoise-500` — `color-palette.json/turquoise-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "turquoise-500", lightHex: 0xFF27CAD8, darkHex: 0xFF03545C)
    }
    /// `turquoise-600` — `color-palette.json/turquoise-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "turquoise-600", lightHex: 0xFF0FB1C0, darkHex: 0xFF056770)
    }
    /// `turquoise-700` — `color-palette.json/turquoise-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "turquoise-700", lightHex: 0xFF0C9EAB, darkHex: 0xFF077883)
    }
    /// `turquoise-800` — `color-palette.json/turquoise-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "turquoise-800", lightHex: 0xFF0A8D99, darkHex: 0xFF09838E)
    }
    /// `turquoise-900` — `color-palette.json/turquoise-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "turquoise-900", lightHex: 0xFF087E89, darkHex: 0xFF0B97A4)
    }
    /// `turquoise-1000` — `color-palette.json/turquoise-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "turquoise-1000", lightHex: 0xFF056B74, darkHex: 0xFF0DA8B6)
    }
    /// `turquoise-1100` — `color-palette.json/turquoise-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "turquoise-1100", lightHex: 0xFF035A62, darkHex: 0xFF10BACA)
    }
    /// `turquoise-1200` — `color-palette.json/turquoise-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "turquoise-1200", lightHex: 0xFF014A51, darkHex: 0xFF40D0DC)
    }
    /// `turquoise-1300` — `color-palette.json/turquoise-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "turquoise-1300", lightHex: 0xFF003B41, darkHex: 0xFF80E1E7)
    }
    /// `turquoise-1400` — `color-palette.json/turquoise-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "turquoise-1400", lightHex: 0xFF002C31, darkHex: 0xFFB7F0F0)
    }
    /// `turquoise-1500` — `color-palette.json/turquoise-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "turquoise-1500", lightHex: 0xFF002023, darkHex: 0xFFE4F9F9)
    }
    /// `turquoise-1600` — `color-palette.json/turquoise-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "turquoise-1600", lightHex: 0xFF000F11, darkHex: 0xFFFFFFFF)
    }
}

/// `yellow` family — 16 shades from `color-palette.json`.
public struct YellowPaletteColors: Sendable {
    public init() {}
    /// `yellow-100` — `color-palette.json/yellow-100`
    public var s100: SpectrumColor {
        SpectrumColor(id: "yellow-100", lightHex: 0xFFFFF8CC, darkHex: 0xFF251700)
    }
    /// `yellow-200` — `color-palette.json/yellow-200`
    public var s200: SpectrumColor {
        SpectrumColor(id: "yellow-200", lightHex: 0xFFFFF197, darkHex: 0xFF2F1D00)
    }
    /// `yellow-300` — `color-palette.json/yellow-300`
    public var s300: SpectrumColor {
        SpectrumColor(id: "yellow-300", lightHex: 0xFFFFDE2C, darkHex: 0xFF3D2700)
    }
    /// `yellow-400` — `color-palette.json/yellow-400`
    public var s400: SpectrumColor {
        SpectrumColor(id: "yellow-400", lightHex: 0xFFF5C700, darkHex: 0xFF533400)
    }
    /// `yellow-500` — `color-palette.json/yellow-500`
    public var s500: SpectrumColor {
        SpectrumColor(id: "yellow-500", lightHex: 0xFFE6AF00, darkHex: 0xFF6B4300)
    }
    /// `yellow-600` — `color-palette.json/yellow-600`
    public var s600: SpectrumColor {
        SpectrumColor(id: "yellow-600", lightHex: 0xFFD29500, darkHex: 0xFF825200)
    }
    /// `yellow-700` — `color-palette.json/yellow-700`
    public var s700: SpectrumColor {
        SpectrumColor(id: "yellow-700", lightHex: 0xFFC18300, darkHex: 0xFF976100)
    }
    /// `yellow-800` — `color-palette.json/yellow-800`
    public var s800: SpectrumColor {
        SpectrumColor(id: "yellow-800", lightHex: 0xFFAF7400, darkHex: 0xFFA46A00)
    }
    /// `yellow-900` — `color-palette.json/yellow-900`
    public var s900: SpectrumColor {
        SpectrumColor(id: "yellow-900", lightHex: 0xFF9E6600, darkHex: 0xFFBA7C00)
    }
    /// `yellow-1000` — `color-palette.json/yellow-1000`
    public var s1000: SpectrumColor {
        SpectrumColor(id: "yellow-1000", lightHex: 0xFF865500, darkHex: 0xFFCB8D00)
    }
    /// `yellow-1100` — `color-palette.json/yellow-1100`
    public var s1100: SpectrumColor {
        SpectrumColor(id: "yellow-1100", lightHex: 0xFF724800, darkHex: 0xFFDA9F00)
    }
    /// `yellow-1200` — `color-palette.json/yellow-1200`
    public var s1200: SpectrumColor {
        SpectrumColor(id: "yellow-1200", lightHex: 0xFF5D3B00, darkHex: 0xFFEBB700)
    }
    /// `yellow-1300` — `color-palette.json/yellow-1300`
    public var s1300: SpectrumColor {
        SpectrumColor(id: "yellow-1300", lightHex: 0xFF4B2F00, darkHex: 0xFFF9CE00)
    }
    /// `yellow-1400` — `color-palette.json/yellow-1400`
    public var s1400: SpectrumColor {
        SpectrumColor(id: "yellow-1400", lightHex: 0xFF382300, darkHex: 0xFFFFE656)
    }
    /// `yellow-1500` — `color-palette.json/yellow-1500`
    public var s1500: SpectrumColor {
        SpectrumColor(id: "yellow-1500", lightHex: 0xFF281900, darkHex: 0xFFFFF6C3)
    }
    /// `yellow-1600` — `color-palette.json/yellow-1600`
    public var s1600: SpectrumColor {
        SpectrumColor(id: "yellow-1600", lightHex: 0xFF120B00, darkHex: 0xFFFFFFFF)
    }
}

