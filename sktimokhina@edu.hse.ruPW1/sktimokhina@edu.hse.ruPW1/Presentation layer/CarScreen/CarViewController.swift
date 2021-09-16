//
//  CarViewController.swift
//  sktimokhina@edu.hse.ruPW1
//
//  Created by Софья Тимохина on 16.09.2021.
//

import UIKit

final class CarViewController: UIViewController {
    private var car: Car!
    private var carWidth: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        carWidth = view.frame.width / 1.2
        car = Car(frame: CGRect(x: -carWidth, y: 10, width: carWidth, height: view.frame.height / 1.5))
        view.addSubview(car)
    }
}
