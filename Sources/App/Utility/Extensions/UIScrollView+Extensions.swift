import UIKit

public extension UIScrollView {
    func scrollToBottom(_ animated: Bool) {
        scrollRectToVisible(CGRect(x: 0.0,
                                   y: contentSize.height - frame.height,
                                   width: contentSize.width,
                                   height: frame.height),
                            animated: animated)
    }

    func scrollToTop(_ animated: Bool) {
        scrollRectToVisible(CGRect(x: 0.0,
                                   y: 0.0,
                                   width: contentSize.width,
                                   height: frame.height),
                            animated: animated)
    }
}
