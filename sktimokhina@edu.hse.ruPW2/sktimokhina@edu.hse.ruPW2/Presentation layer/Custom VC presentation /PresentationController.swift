//
//  PresentationController.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 19.09.2021.
//

import UIKit

final class PresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let viewFrame = presentedView?.bounds.size,
              let containerViewFrame = containerView?.frame else { return .zero }
        let insets: CGFloat = 16
        let safeAreaInsets = containerView?.safeAreaInsets ?? .zero
        return CGRect(x: 0,
                      y: containerViewFrame.height - viewFrame.height - insets - safeAreaInsets.bottom,
                      width: viewFrame.width,
                      height: viewFrame.height + insets + safeAreaInsets.bottom)
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        let recognizer = UITapGestureRecognizer(
          target: self,
          action: #selector(handleTap(recognizer:)))
        containerView?.addGestureRecognizer(recognizer)
    }

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        presentedView?.autoresizingMask = [
            .flexibleTopMargin,
            .flexibleBottomMargin,
            .flexibleLeftMargin,
            .flexibleRightMargin
        ]
        presentedView?.layer.cornerRadius = 20

        presentedView?.translatesAutoresizingMaskIntoConstraints = true
    }

    @objc func handleTap(recognizer: UITapGestureRecognizer) {
      presentingViewController.dismiss(animated: true)
    }

    override func dismissalTransitionWillBegin() {
      guard let coordinator = presentedViewController.transitionCoordinator else {
        presentedView?.alpha = 0.0
        return
      }

      coordinator.animate(alongsideTransition: { _ in
        self.presentedView?.alpha = 0.0
      })
    }
}
