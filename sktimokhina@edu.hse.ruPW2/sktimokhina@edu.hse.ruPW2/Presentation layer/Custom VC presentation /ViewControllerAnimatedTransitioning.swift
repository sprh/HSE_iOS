//
//  ViewControllerAnimatedTransitioning.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 19.09.2021.
//

import UIKit

final class ViewControllerAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    private let type: AnimationType
    enum AnimationType {
        case present
        case dismiss
    }

    init(type: AnimationType) {
        self.type = type
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .present:
            animatePresentation(using: transitionContext)
        case .dismiss:
            animateDismission(using: transitionContext)
        }
    }

    private func animatePresentation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        let containerView = transitionContext.containerView
        let animationDuration = transitionDuration(using: transitionContext)

        containerView.addSubview(toViewController.view)

        UIView.animate(withDuration: animationDuration, animations: {
            toViewController.view.transform = CGAffineTransform(translationX: 0, y: -containerView.bounds.height)
            }, completion: { finished in
                transitionContext.completeTransition(finished)
        })

    }

    private func animateDismission(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        let containerView = transitionContext.containerView
        let animationDuration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: animationDuration, animations: {
            fromViewController.view.transform = CGAffineTransform(translationX: 0, y: -containerView.bounds.height)
        }) { finished in
            transitionContext.completeTransition(finished)
            fromViewController.view.removeFromSuperview()
        }
    }
}




