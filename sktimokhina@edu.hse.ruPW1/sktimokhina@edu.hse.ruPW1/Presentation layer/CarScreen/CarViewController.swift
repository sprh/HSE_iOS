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
    private var previousOrientation: UIInterfaceOrientation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previousOrientation = UIApplication.orientation
        view.backgroundColor = .background
        carWidth = view.frame.width / 1.3
        car = Car(frame: CGRect(x: -carWidth, y: 10, width: carWidth, height: view.frame.height / 1.5))
        view.addSubview(car)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateCar()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeOrientation),
                                               name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        car.stopAnimation()
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    func didChangeOrientation() {
        let currentOrientation = UIApplication.orientation
        if currentOrientation != previousOrientation {
            car.stopAnimation()
            carWidth = view.frame.width / 1.3
            car.frame = CGRect(x: -carWidth, y: 10, width: carWidth, height: view.frame.height / 1.5)
            animateCar()

        }
        previousOrientation = currentOrientation
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
