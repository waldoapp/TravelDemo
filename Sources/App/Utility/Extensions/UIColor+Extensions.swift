import UIKit

public extension UIColor {
    convenience init(hex: String,
                     alpha: CGFloat = 1.0) {
        let scanner = Scanner(string: hex)

        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanLocation = 0

        var rgb: UInt32 = 0

        scanner.scanHexInt32(&rgb)

        let red = (rgb >> 16) & 0xff
        let green = (rgb >> 8) & 0xff
        let blue = rgb & 0xff

        self.init(red: CGFloat(red) / 0xff,
                  green: CGFloat(green) / 0xff,
                  blue: CGFloat(blue) / 0xff,
                  alpha: alpha)
    }
}
