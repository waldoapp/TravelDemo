import UIKit

public class OnboardingViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: OnboardingViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var leftDotImageView: UIImageView!
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var rightDotImageView: UIImageView!

    // MARK: Private Instance Methods

    @IBAction private func actionButtonTapped(_ sender: Any) {
        guard let mc = mainCoordinator,
              let vm = viewModel
        else { return }

        mc.providers.analytics.trackUIButtonTapped("action",
                                                   screen: "onboarding")

        if let step = vm.nextStep {
            mc.showOnboarding(for: step)
        } else {
            mc.showSpotList(mySpots: false)
        }
    }

    // MARK: Overridden BaseViewController Instance Methods

    override public func bindViewModel() {
        guard isViewLoaded,
              let vm = viewModel
        else { return }

        actionButton.setTitle(vm.actionTitle,
                              for: .normal)

        leftDotImageView.image = vm.leftDotImage

        mainImageView.image = vm.mainImage

        messageLabel.text = vm.messageText

        rightDotImageView.image = vm.rightDotImage
    }

    override public func configureSubviews() {
        actionButton.setTitle(nil,
                              for: .normal)

        leftDotImageView.image = nil

        mainImageView.image = nil

        messageLabel.text = nil

        rightDotImageView.image = nil
    }
}
