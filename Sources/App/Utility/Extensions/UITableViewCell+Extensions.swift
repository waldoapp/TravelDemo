import UIKit

public extension UITableViewCell {
    static func instantiate(from tableView: UITableView,
                            for indexPath: IndexPath) -> Self? {
        let cellID = "\(self)"

        return tableView.dequeueReusableCell(withIdentifier: cellID,
                                             for: indexPath) as? Self
    }
}
