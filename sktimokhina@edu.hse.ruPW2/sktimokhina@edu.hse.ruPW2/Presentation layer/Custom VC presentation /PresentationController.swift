//
//  PresentationController.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 19.09.2021.
//

import UIKit

final class PresentationController: UIPresentationController {
    var panGestureAnchorPoint: CGPoint?
    private var recognizer: UITapGestureRecognizer!

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
        recognizer = UITapGestureRecognizer(
          target: self,
          action: #selector(handleTap(recognizer:)))
        containerView?.addGestureRecognizer(recognizer)
    }


    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: containerView)
        guard let frame = presentedView?.frame, !(frame.minX < location.x &&
                                                  location.x < frame.maxX &&
                                                  frame.minY < location.y) else {
            return
        }

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
