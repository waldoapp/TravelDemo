import UIKit

public class SlideTransitionAnimator: NSObject {

    // MARK: Public Nested Types

    public enum Transition {
        case bottomIn
        case bottomOut
        case leftIn
        case leftOut
        case rightIn
        case rightOut
        case topIn
        case topOut
    }

    // MARK: Public Initializers

    public init(transition: Transition,
                duration: TimeInterval) {
        self.duration = duration
        self.transition = transition
    }

    // MARK: Public Instance Properties

    public let duration: TimeInterval
    public let transition: Transition
}

// MARK: - UIViewControllerAnimatedTransitioning

extension SlideTransitionAnimator: UIViewControllerAnimatedTransitioning {
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let fromVC = transitionContext.viewController(forKey: .from),
              let fromView = fromVC.view,
              let toVC = transitionContext.viewController(forKey: .to),
              let toView = toVC.view,
              fromView.superview == containerView
        else { return }

        let duration = transitionDuration(using: transitionContext)
        let completion: (Bool) -> Void = { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        let fromFrameInitial = transitionContext.initialFrame(for: fromVC)
        let toFrameFinal = transitionContext.finalFrame(for: toVC)

        var fromFrameFinal: CGRect = .zero
        var toFrameInitial: CGRect = .zero

        switch transition {
        case .bottomIn,
             .leftIn,
             .rightIn,
             .topIn:
            fromFrameFinal = fromFrameInitial

            if toView.superview != containerView {
                containerView.insertSubview(toView,
                                            aboveSubview: fromView)
            }

        case .bottomOut,
             .leftOut,
             .rightOut,
             .topOut:
            toFrameInitial = toFrameFinal

            if toView.superview != containerView {
                containerView.insertSubview(toView,
                                            belowSubview: fromView)
            }
        }

        switch transition {
        case .bottomIn:
            toFrameInitial = toFrameFinal
            toFrameInitial.origin.y = containerView.bounds.maxY

        case .bottomOut:
            fromFrameFinal = fromFrameInitial
            fromFrameFinal.origin.y = containerView.bounds.maxY

        case .leftIn :
            toFrameInitial = toFrameFinal
            toFrameInitial.origin.x = containerView.bounds.minX - toFrameInitial.width

        case .leftOut :
            fromFrameFinal = fromFrameInitial
            fromFrameFinal.origin.x = containerView.bounds.minX - fromFrameFinal.width

        case .rightIn :
            toFrameInitial = toFrameFinal
            toFrameInitial.origin.x = containerView.bounds.maxX

        case .rightOut :
            fromFrameFinal = fromFrameInitial
            fromFrameFinal.origin.x = containerView.bounds.maxX

        case .topIn :
            toFrameInitial = toFrameFinal
            toFrameInitial.origin.y = containerView.bounds.minY - toFrameInitial.height

        case .topOut :
            fromFrameFinal = fromFrameInitial
            fromFrameFinal.origin.y = containerView.bounds.minY - fromFrameFinal.height
        }

        fromView.frame = fromFrameInitial

        fromView.layoutIfNeeded()

        toVC.view.frame = toFrameInitial

        toView.layoutIfNeeded()

        UIView.animate(withDuration: duration,
                       animations: {
                        fromView.frame = fromFrameFinal
                        toView.frame = toFrameFinal },
                       completion: completion)
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
}
