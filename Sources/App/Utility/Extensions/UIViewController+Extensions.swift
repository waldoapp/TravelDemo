import UIKit

public extension UIViewController {
    static func instantiate(from name: StoryboardName) -> Self? {
        let sb = UIStoryboard(name: name.rawValue,
                              bundle: nil)

        return sb.instantiateViewController(withIdentifier: "\(self)ID") as? Self
    }
}
