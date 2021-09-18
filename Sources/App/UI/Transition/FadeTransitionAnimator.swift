import UIKit

public class FadeTransitionAnimator: NSObject {

    // MARK: Public Nested Types

    public enum Transition {
        case cross
        case `in`
        case out
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

    // MARK: Private Instance Methods

    private func _animateCrossFade(with containerView: UIView,
                                   from fromView: UIView,
                                   to toView: UIView,
                                   duration: TimeInterval,
                                   completion: ((Bool) -> Void)? = nil) {
        if toView.superview != containerView {
            containerView.insertSubview(toView,
                                        aboveSubview: fromView)
        }

        UIView.transition(from: fromView,
                          to: toView,
                          duration: duration,
                          options: [.showHideTransitionViews,
                                    .transitionCrossDissolve],
                          completion: completion)
    }

    private func _animateFadeIn(with containerView: UIView,
                                from fromView: UIView,
                                to toView: UIView,
                                duration: TimeInterval,
                                completion: ((Bool) -> Void)? = nil) {
        if toView.superview != containerView {
            containerView.insertSubview(toView,
                                        aboveSubview: fromView)
        }

        toView.alpha = 0.0

        UIView.animate(withDuration: duration,
                       animations: { toView.alpha = 1.0 },
                       completion: completion)
    }

    private func _animateFadeOut(with containerView: UIView,
                                 from fromView: UIView,
                                 to toView: UIView,
                                 duration: TimeInterval,
                                 completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration,
                       animations: { fromView.alpha = 0.0 },
                       completion: completion)
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension FadeTransitionAnimator: UIViewControllerAnimatedTransitioning {
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let fromView = transitionContext.viewController(forKey: .from)?.view,
              let toView = transitionContext.viewController(forKey: .to)?.view,
              fromView.superview == containerView
        else { return }

        let duration = transitionDuration(using: transitionContext)
        let completion: (Bool) -> Void = { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        switch transition {
        case .cross:
            _animateCrossFade(with: containerView,
                              from: fromView,
                              to: toView,
                              duration: duration,
                              completion: completion)

        case .`in`:
            _animateFadeIn(with: containerView,
                           from: fromView,
                           to: toView,
                           duration: duration,
                           completion: completion)

        case .out:
            _animateFadeOut(with: containerView,
                            from: fromView,
                            to: toView,
                            duration: duration,
                            completion: completion)
        }
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
}
