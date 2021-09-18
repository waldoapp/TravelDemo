import UIKit

public class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView {

    // MARK: Public Instance Methods

    public func bindViewModel() {
    }

    // MARK: Overridden NSObject Methods

    override public func awakeFromNib() {
        super.awakeFromNib()

        bindViewModel()
    }
}
