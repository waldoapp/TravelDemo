import UIKit

internal class DefaultFonts: ThemeFonts {
    internal let bodyLarge = _makeFont("Inter-Medium", 14)
    internal let bodySmall1 = _makeFont("Inter-Medium", 13)
    internal let bodySmall2 = _makeFont("Inter-Bold", 13)
    internal let bodySmall3 = _makeFont("Inter-Regular", 13)
    internal let buttonLarge = _makeFont("Inter-Medium", 14)
    internal let buttonSmall = _makeFont("Inter-Bold", 24)
    internal let captionLarge = _makeFont("Inter-Medium", 12)
    internal let captionSmall = _makeFont("Inter-Medium", 11)
    internal let headline0 = _makeFont("Poppins-SemiBold", 60)
    internal let headline1 = _makeFont("Poppins-SemiBold", 48)
    internal let headline2 = _makeFont("Poppins-SemiBold", 40)
    internal let headline3 = _makeFont("Poppins-SemiBold", 36)
    internal let headline4 = _makeFont("Poppins-SemiBold", 32)
    internal let headline5 = _makeFont("Poppins-SemiBold", 24)
    internal let headline6 = _makeFont("Poppins-SemiBold", 20)
    internal let label = _makeFont("Inter-Bold", 10)
    internal let tab = _makeFont("Inter-SemiBold", 14)
    internal let titleLarge = _makeFont("Poppins-SemiBold", 18)
    internal let titleMedium = _makeFont("Inter-SemiBold", 16)
    internal let titleSmall = _makeFont("Inter-SemiBold", 14)
}

// MARK: -

private func _makeFont(_ name: String,
                       _ size: CGFloat) -> UIFont {
    let fontDesc = UIFontDescriptor(name: name,
                                    size: size)

    return UIFont(descriptor: fontDesc,
                  size: size)
}
