import ObjectiveC
import UIKit

public extension UIAlertController {
    func setAccessibilityIdentifiers() {
        for action in actions {
            if let view = action.value(forKey: "__representer") as? UIView {
                view.accessibilityIdentifier = action.accessibilityIdentifier
            }
        }
    }
}

private var associatedKey: Void?

public extension UIAlertAction {
    var accessibilityIdentifier: String? {
        get { objc_getAssociatedObject(self,
                                       &associatedKey) as? String }
        set { objc_setAssociatedObject(self,
                                       &associatedKey,
                                       newValue,
                                       .OBJC_ASSOCIATION_RETAIN) }
    }
}
