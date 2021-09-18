import UIKit

public class OnboardingViewModel: ViewModel {

    // MARK: Public Instance Initializer

    public init(_ step: Int) {
        self.actionTitle = "ONBOARDING.BUTTON.TITLE.\(step)".localized
        self.image = UIImage(named: "onboarding_Step_\(step)")
        self.messageText = "ONBOARDING.SCREEN.MESSAGE.\(step)".localized
        self.step = step
    }

    // MARK: Public Instance Properties

    public let actionTitle: String
    public let image: UIImage?
    public let messageText: String

    public var nextStep: Int? {
        if step < 2 {
            return step + 1
        }

        return nil
    }

    // MARK: Private Instance Properties

    private let step: Int
}
