import UIKit

public class Coordinator {

    // MARK: Public Initializers

    public init(_ navigationController: UINavigationController) {
        self.children = []
        self.navigationController = navigationController
    }

    // MARK: Public Instance Properties

    public let navigationController: UINavigationController

    public private(set) var children: [Coordinator]

    // MARK: Public Instance Methods

    public func addChild(_ child: Coordinator) {
        children.append(child)
    }

    public func removeChild(_ child: Coordinator) {
        guard let idx = children.firstIndex(where: { $0 === child })
        else { return }

        children.remove(at: idx)
    }

    public func start() {
    }
}
