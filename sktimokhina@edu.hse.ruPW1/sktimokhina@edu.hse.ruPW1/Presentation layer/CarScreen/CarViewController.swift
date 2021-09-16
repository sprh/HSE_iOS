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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateCar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        car.stopAnimation()
    }

    func animateCar() {
        car.frame = CGRect(x: -carWidth, y: 10, width: carWidth, height: view.frame.height / 1.5)
        car.startAnimation()
        UIView.animate(withDuration: 5.0, delay: 0, options: [.curveLinear, .repeat], animations: { [weak self] in
            guard let self = self else { return }
            self.car.frame = CGRect(x: self.view.frame.width, y: 10, width: self.car.frame.width, height: self.car.frame.height)
        }, completion: nil)
    }
}
