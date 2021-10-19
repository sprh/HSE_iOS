//
//  TouchForwardingView.swift
//  sktimokhina@edu.hse.ruPW2
//
//  Created by Софья Тимохина on 19.09.2021.
//

import UIKit

final class TouchForwardingView: UIView {

    var passthroughViews: [UIView] = []
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event),
              hitView == self else { return nil }
        for view in passthroughViews {
            let point = convert(point, to: view)
            if let hitView = view.hitTest(point, with: event) {
                return hitView
            }
        }
        return self
    }
}
