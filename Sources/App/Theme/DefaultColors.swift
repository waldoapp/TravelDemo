import UIKit

internal class DefaultColors: ThemeColors {
    internal let active = _makeColor(0xffffff)
    internal let activeLightMode = _makeColor(0x200745)
    internal let background1 = _makeColor(0x181a20)
    internal let background2 = _makeColor(0x5c6171)
    internal let backgroundBlur = _makeColor(0x181a20, 0.85)
    internal let colorful1 = _makeColor(0xa06af9)
    internal let colorful2 = _makeColor(0xfba3ff)
    internal let colorful3 = _makeColor(0x8e96ff)
    internal let colorful4 = _makeColor(0x94f0f0)
    internal let colorful5 = _makeColor(0xa5f59c)
    internal let colorful6 = _makeColor(0xffdd72)
    internal let colorful7 = _makeColor(0xff968e)
    internal let deactive = _makeColor(0x83889c)
    internal let deactiveDarker = _makeColor(0xa0a4b1)
    internal let primary = _makeColor(0x246bfd)
    internal let secondary = _makeColor(0xc25fff)
    internal let white = _makeColor(0xffffff)
}

// MARK: -

private func _makeColor(_ rgb: Int,
                        _ alpha: CGFloat = 1.0) -> UIColor {
    UIColor(rgb: UInt32(rgb),
            alpha: alpha)
}
