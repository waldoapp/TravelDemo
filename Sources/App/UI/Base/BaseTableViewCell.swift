import UIKit

public class BaseTableViewCell: UITableViewCell {

    // MARK: Public Instance Methods

    public func bindViewModel() {
    }

    public func configureSubviews() {
    }

    // MARK: Overridden NSObject Methods

    override public func awakeFromNib() {
        super.awakeFromNib()

        configureSubviews()
        bindViewModel()
    }
}
