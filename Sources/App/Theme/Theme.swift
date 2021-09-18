import UIKit

public class Theme {

    // MARK: Public Type Properties

    public static let `default` = Theme(colors: DefaultColors(),
                                        fonts: DefaultFonts())

    // MARK: Public Instance Properties

    public let colors: ThemeColors
    public let fonts: ThemeFonts

    // MARK: Private Initializers

    private init(colors: ThemeColors,
                 fonts: ThemeFonts) {
        self.colors = colors
        self.fonts = fonts
    }
}

// MARK: -

public protocol ThemeColors {
    var active: UIColor { get }
    var activeLightMode: UIColor { get }
    var background1: UIColor { get }
    var background2: UIColor { get }
    var backgroundBlur: UIColor { get }
    var colorful1: UIColor { get }
    var colorful2: UIColor { get }
    var colorful3: UIColor { get }
    var colorful4: UIColor { get }
    var colorful5: UIColor { get }
    var colorful6: UIColor { get }
    var colorful7: UIColor { get }
    var deactive: UIColor { get }
    var deactiveDarker: UIColor { get }
    var primary: UIColor { get }
    var secondary: UIColor { get }
    var white: UIColor { get }
}

// MARK: -

public protocol ThemeFonts {
    var bodyLarge: UIFont { get }
    var bodySmall1: UIFont { get }
    var bodySmall2: UIFont { get }
    var bodySmall3: UIFont { get }
    var buttonLarge: UIFont { get }
    var buttonSmall: UIFont { get }
    var captionLarge: UIFont { get }
    var captionSmall: UIFont { get }
    var headline0: UIFont { get }
    var headline1: UIFont { get }
    var headline2: UIFont { get }
    var headline3: UIFont { get }
    var headline4: UIFont { get }
    var headline5: UIFont { get }
    var headline6: UIFont { get }
    var label: UIFont { get }
    var tab: UIFont { get }
    var titleLarge: UIFont { get }
    var titleMedium: UIFont { get }
    var titleSmall: UIFont { get }
}
