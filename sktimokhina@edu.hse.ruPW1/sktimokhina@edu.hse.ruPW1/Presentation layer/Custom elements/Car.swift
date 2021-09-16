//
//  Car.swift
//  sktimokhina@edu.hse.ruPW1
//
//  Created by Софья Тимохина on 16.09.2021.
//

import UIKit

final class Car: UIView {
    private var firstWheel: UIView!
    private var secondWheel: UIView!
    private var body: [UIView] = []
    private var animationIndex: Int?

    override init(frame: CGRect) {
        super.init(frame: frame)
        generateWheels()
        generateWhelsBody()
        generateBody()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func generateWheels() {
        let wheelWidth = frame.width / 5
        firstWheel = ShapeButton(viewModel:
                                    ShapeButton.ViewModel(height: wheelWidth,
                                                          width: wheelWidth,
                                                          x: wheelWidth,
                                                          y: frame.height - wheelWidth,
                                                          cornerRadius: wheelWidth / 1.7,
                                                          backgroundColor: "#a5d6a7"))
        secondWheel = ShapeButton(viewModel:
                                    ShapeButton.ViewModel(height: wheelWidth,
                                                          width: wheelWidth,
                                                          x: frame.width - wheelWidth,
                                                          y: frame.height - wheelWidth,
                                                          cornerRadius: wheelWidth / 1.7,
                                                          backgroundColor: "#a5d6a7"))
        addSubview(firstWheel)
        addSubview(secondWheel)
    }

    private func generateWhelsBody() {
        let wheelWidth = firstWheel.frame.width / 1.5
        firstWheel.addSubview(ShapeButton(viewModel:
                                            ShapeButton.ViewModel(height: wheelWidth,
                                                                  width: wheelWidth,
                                                                  x: (firstWheel.frame.width - wheelWidth) / 2,
                                                                  y: (firstWheel.frame.width - wheelWidth) / 2,
                                                                  cornerRadius: wheelWidth / 1.5,
                                                                  backgroundColor: "#F6FAF6")))
        secondWheel.addSubview(ShapeButton(viewModel:
                                            ShapeButton.ViewModel(height: wheelWidth,
                                                                  width: wheelWidth,
                                                                  x: (secondWheel.frame.width - wheelWidth) / 2,
                                                                  y: (secondWheel.frame.width - wheelWidth) / 2,
                                                                  cornerRadius: wheelWidth / 1.5,
                                                                  backgroundColor: "#F6FAF6")))
        addSubview(secondWheel)
    }

    func startAnimation() {
        animationIndex = 0
        animateWheel(wheel: firstWheel)
        animateWheel(wheel: secondWheel)
        animateBody()
    }

    func stopAnimation() {
        animationIndex = nil
        subviews.forEach({$0.layer.removeAllAnimations()})
        layer.removeAllAnimations()
        layoutIfNeeded()
    }

    private func animateWheel(wheel: UIView) {
        UIView.animate(withDuration: 2, delay: 0, options: [.repeat], animations: {
            wheel.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi)))
        }, completion: nil)
    }

    private func animateBody() {
        guard let index = animationIndex else {
            return
        }
        if index >= body.count {
            animationIndex = 0
            animateBody()
            return
        }
        let currentView = body[index]
        UIView.animate(withDuration: 0.1, delay: 0, options: [.autoreverse, .curveLinear], animations: { 
            currentView.frame = CGRect(x: currentView.frame.minX,
                                       y: currentView.frame.minY - 15,
                                       width: currentView.frame.width,
                                       height: currentView.frame.height)
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            self.animationIndex = self.animationIndex == nil ? nil : index + 1
            self.animateBody()
            UIView.animate(withDuration: 0.1, delay: 0, options: [.autoreverse, .curveLinear], animations: {
                currentView.frame = CGRect(x: currentView.frame.minX,
                                           y: currentView.frame.minY + 15,
                                           width: currentView.frame.width,
                                           height: currentView.frame.height)
            }, completion: nil
            )})
    }

    private func generateBody() {
        let width = frame.width / 32
        var height = firstWheel.frame.height
        var y: CGFloat = firstWheel.frame.minY - height / 2
        var x: CGFloat = firstWheel.frame.minX - firstWheel.frame.width / 1.2
        var index = 0
        while x < secondWheel.frame.maxX + secondWheel.frame.width / 8 {
            let viewModel = ShapeButton.ViewModel(height: height,
                                                  width: width,
                                                  x: x,
                                                  y: y,
                                                  cornerRadius: 10,
                                                  backgroundColor: "#526B53")
            let button = ShapeButton(viewModel: viewModel)
            addSubview(button)
            body.append(button)
            x += width * 2
            if (x + width) < firstWheel.frame.minX {
                height *= 1.3
                y = firstWheel.frame.minY - height / 2
            } else if (x + width) > firstWheel.frame.minX,
                      (x + width) < firstWheel.frame.maxX {
                index += 1;
                let maxCount = Int(firstWheel.frame.width / (width * 2))
                let additionHeight = CGFloat((index == maxCount / 2 ? 0 :
                                                (index > maxCount / 2 ? maxCount - index + 1 : index) * 7))
                height = firstWheel.frame.height
                if index == maxCount {
                    height += additionHeight * 2
                }
                y = firstWheel.frame.minY - height - additionHeight
            } else if (x + width) > firstWheel.frame.maxX,
                      (x + width) < secondWheel.frame.minX {
                index = index > 0 ? -1 : index - 1;
                height = firstWheel.frame.width * 2 + CGFloat(index * 10)
                y = firstWheel.frame.midY - height
            } else if (x + width) < secondWheel.frame.maxX {
                if index < 0 {
                    index = 0
                }
                index += 1
                let maxCount = Int(secondWheel.frame.width / (width * 2))
                let additionHeight: CGFloat = CGFloat((index == maxCount / 2 ? 0 :
                                                        (index > maxCount / 2 ? maxCount - index + 1 : index) * 3))
                height = firstWheel.frame.height / 1.4
                if index == maxCount {
                    height += additionHeight * 2
                }
                y = secondWheel.frame.minY - height - additionHeight
            } else {
                height *= 1.1
                y = secondWheel.frame.minY - height / 1.2
            }
        }
    }
}