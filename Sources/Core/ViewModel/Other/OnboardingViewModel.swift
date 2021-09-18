import UIKit

public class OnboardingViewModel: ViewModel {

    // MARK: Public Instance Initializer

    public init(_ step: Int) {
        self.actionTitle = "ONBOARDING.BUTTON.TITLE.\(step)".localized
        self.leftDotImage = Self._dotImages(for: step).left
        self.mainImage = UIImage(named: "onboarding_Step_\(step)")
        self.messageText = "ONBOARDING.SCREEN.MESSAGE.\(step)".localized
        self.rightDotImage = Self._dotImages(for: step).right
        self.step = step
    }

    // MARK: Public Instance Properties

    public let actionTitle: String
    public let leftDotImage: UIImage?
    public let mainImage: UIImage?
    public let messageText: String
    public let rightDotImage: UIImage?

    public var nextStep: Int? {
        if step < 2 {
            return step + 1
        }

        return nil
    }

    // MARK: Private Type Properties

    private static let dotImages = [UIImage(named: "onboarding_dot_disable"),
                                    UIImage(named: "onboarding_dot")]

    // MARK: Private Type Methods

    private static func _dotImages(for step: Int) -> (left: UIImage?, right: UIImage?) {
        switch step {
        case 1, 2:
            return (dotImages[(step >> 0) & 1],
                    dotImages[(step >> 1) & 1])

        default:
            return (nil, nil)
        }
    }

    // MARK: Private Instance Properties

    private let step: Int
}
