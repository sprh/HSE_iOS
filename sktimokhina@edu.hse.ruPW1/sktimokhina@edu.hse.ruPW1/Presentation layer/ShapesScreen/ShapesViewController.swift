//
//  ShapesViewController.swift
//  sktimokhina@edu.hse.ruPW1
//
//  Created by Софья Тимохина on 11.09.2021.
//

import UIKit

final class ShapesViewController: UIViewController {
    private let viewModel: ShapesViewModel

    init(viewModel: ShapesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.frame = view.frame
        viewModel.setup()
        view = viewModel
    }
}
