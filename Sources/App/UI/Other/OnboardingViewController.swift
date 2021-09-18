import UIKit

public class OnboardingViewController: BaseViewController {

    // MARK: Public Instance Properties

    public var viewModel: OnboardingViewModel? { didSet { bindViewModel() } }

    // MARK: Private Instance Properties

    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var messageLabel: UILabel!

    // MARK: Private Instance Methods

    @IBAction private func actionButtonTapped(_ sender: Any) {
        guard let vm = viewModel
        else { return }

        if let step = vm.nextStep {
            coordinator?.showOnboarding(step)
        } else {
            coordinator?.showSpotList()
        }
    }

    // MARK: Overridden BaseViewController Instance Methods

    override public func bindViewModel() {
        super.bindViewModel()

        guard isViewLoaded,
              let vm = viewModel
        else { return }

        actionButton.setTitle(vm.actionTitle,
                              for: .normal)

        imageView.image = vm.image

        messageLabel.text = vm.messageText
    }

    // MARK: Overridden UIViewController Methods

    override public func viewDidLoad() {
        super.viewDidLoad()

        actionButton.layer.borderColor = UIColor.white.cgColor
        actionButton.layer.borderWidth = 2
        actionButton.layer.cornerRadius = actionButton.frame.height / 2
        actionButton.layer.masksToBounds = true
    }
}
