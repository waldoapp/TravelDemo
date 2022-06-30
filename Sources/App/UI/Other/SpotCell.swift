import UIKit

public class SpotCell: BaseTableViewCell {

    // MARK: Public Instance Properties

    public var viewModel: SpotCellViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    @IBOutlet private weak var authorImageView: UIImageView!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var spotImageView: UIImageView!
    @IBOutlet private weak var spotNameLabel: UILabel!

    // MARK: Overridden BaseTableViewCell Instance Methods

    override public func bindViewModel() {
        guard let vm = viewModel
        else { return }

        authorImageView.image = vm.authorImage ?? UIImage(named: "avatar_fallbacks")

        authorNameLabel.text = vm.authorNameText

        spotImageView.image = vm.spotImage

        spotNameLabel.text = vm.spotNameText
    }

    override public func configureSubviews() {
        authorImageView.image = nil
        authorImageView.layer.cornerRadius = authorImageView.frame.height / 2
        authorImageView.layer.masksToBounds = true

        authorNameLabel.text = nil

        cardView.layer.cornerRadius = 12
        cardView.layer.masksToBounds = true

        spotImageView.image = nil
        spotImageView.layer.cornerRadius = 16
        spotImageView.layer.masksToBounds = true

        spotNameLabel.text = nil
    }
}
