import UIKit

public protocol ProviderDelegate: AnyObject {
    func dismiss(_ vc: UIViewController)

    func present(_ vc: UIViewController)
}
