import UIKit

public extension UIColor {
    convenience init(rgb: UInt32,
                     alpha: CGFloat = 1.0) {
        let red = (rgb >> 16) & 0xff
        let green = (rgb >> 8) & 0xff
        let blue = rgb & 0xff

        self.init(red: CGFloat(red) / 0xff,
                  green: CGFloat(green) / 0xff,
                  blue: CGFloat(blue) / 0xff,
                  alpha: alpha)
    }
}
