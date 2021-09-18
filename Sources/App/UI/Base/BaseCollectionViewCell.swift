import UIKit

public class BaseCollectionViewCell: UICollectionViewCell {

    // MARK: Public Instance Methods

    public func bindViewModel() {
    }

    // MARK: Overridden NSObject Methods

    override public func awakeFromNib() {
        super.awakeFromNib()

        bindViewModel()
    }
}
