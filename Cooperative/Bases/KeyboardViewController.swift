//
//  KeyboardViewController.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import IQKeyboardManagerSwift
import UIKit

// MARK: - KeyboardViewController
/// This class is used to update the constraint of the view when the keyboard appears or disappears

class KeyboardViewController: BaseViewController {
    private var constraintToUpdate: NSLayoutConstraint?
    private var constraintConstantDefault: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillDisappear),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillAppear),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func setKeyboardAvoidConstraint(_ constraintToUpdate: NSLayoutConstraint) {
        self.constraintToUpdate = constraintToUpdate
        constraintConstantDefault = constraintToUpdate.constant
    }

    // Change the constraint constant to the keyboard height on keyboard will appear
    @objc private func keyboardWillAppear(notification: NSNotification) {
        let newConstant = constraintConstantDefault + keyboardHeight(notification: notification)
        constraintToUpdate?.updateConstantWithAnimation(newConstant, view)
    }

    // Change the constraint constant to the keyboard height on keyboard will disappear
    @objc private func keyboardWillDisappear(notification: NSNotification) {
        constraintToUpdate?.updateConstantWithAnimation(constraintConstantDefault, view)
    }
}
