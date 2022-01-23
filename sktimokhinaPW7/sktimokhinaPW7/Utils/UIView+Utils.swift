//
//  UIView+Utils.swift
//  sktimokhinaPW7
//
//  Created by Софья Тимохина on 23.01.2022.
//
import UIKit

extension UIView {
    static func safeAreaHeight() -> CGFloat {
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        let bottomPadding = window.safeAreaInsets.bottom
        return topPadding + bottomPadding
    }

    /// This method helps to hide keyboard.
    /// When keyboard is shown and user taps on the screen keyboard will hide if it was not a text field/view etc.
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }

    /// Chnage a scroll view content inset and scroll indicator inset when keyboard is shown.
    /// This method is suitable not only for a scroll view but also for a table view.
    func keyboardWillShow(_ scrollView: UIScrollView) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                                   object: nil, queue: nil, using: { notification -> Void in
                                                    guard let userInfo = notification.userInfo,
                                                          let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue?.size
                                                    else {return}
                                                    let contentInsets = UIEdgeInsets(top: 0,
                                                                                     left: 0,
                                                                                     bottom: keyboardSize.height,
                                                                                     right: 0)
                                                    scrollView.contentInset = contentInsets
                                                    scrollView.scrollIndicatorInsets = contentInsets
                                                   })
    }

    /// Chnage a scroll view content inset and scroll indicator inset when keyboard is hidden.
    /// This method is suitable not only for a scroll view but also for a table view.
    func keyboardWillHide(_ scrollView: UIScrollView) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                                   object: nil, queue: nil, using: { _ -> Void in
                                                    scrollView.contentInset = .zero
                                                    scrollView.scrollIndicatorInsets = .zero
                                                   })
    }
}
