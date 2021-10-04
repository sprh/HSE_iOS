//
//  UIViewController+Utils.swift
//  sktimokhina@edu.hse.ruPW3
//
//  Created by Софья Тимохина on 04.10.2021.
//

import UIKit

extension UIViewController {
    func createAlarmHeader(_ button: UIBarButtonItem, _ title: String) {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = title
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationItem.rightBarButtonItem = button
    }
}
