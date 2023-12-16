//
//  BaseViewController.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import enum CooperativeDomain.CBErrors
import RxSwift

// MARK: - BaseViewController

/// Usage: BaseViewController().showSnackError(error, hideAfter)

class BaseViewController: UIViewController, RxBaseProtocol, UIGestureRecognizerDelegate {
    var disposeBag = DisposeBag()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.keyWindow?.subviews.forEach { view in
            if view is CBSnackBarView {
                view.removeFromSuperview()
            }
        }
    }

    //  Check if snackbar is showing
    /// - Parameters: none
    /// - Returns: Bool
    /// - Usage: isShowingSnackBar()

    func isShowingSnackBar() -> Bool {
        var result = false
        UIApplication.shared.keyWindow?.subviews.forEach { view in
            if view is CBSnackBarView {
                result = true
            }
        }
        return result
    }

    //  Show error message
    /// - Parameters: error, hideAfter
    /// - Returns: Void
    /// - Usage: showSnackError(error, hideAfter)

    func showSnackError(_ error: Error, _ hideAfter: Bool = true) {
        let timeToHide: Double? = hideAfter ? 4 : nil
        switch error {
        case CBErrors.apiError(_, let message, _, _):
            let model = CBSnackBarView.ViewModel(messageText: message,
                                                 buttonText: Strings.commonOkay.localized().uppercased())
            showSnackBar(model, timeToHide)
        case CBErrors.retryError(let message, let retryAction):
            let model = CBSnackBarView.ViewModel(messageText: message,
                                                 buttonText: Strings.commonTryAgain.localized().uppercased())
            showSnackBar(model, timeToHide, retryAction)
        default:
            let model = CBSnackBarView.ViewModel(messageText: Strings.commonGeneralError.localized(),
                                                 buttonText: Strings.commonOkay.localized().uppercased())
            showSnackBar(model, timeToHide)
        }
    }

    // Show snackbar message
    /// - Parameters: message, hideAfter, retryClosure
    /// - Returns: Void
    /// - Usage: showSnackBar(message, hideAfter, retryClosure)
    /// - Note: hideAfter is optional, retryClosure is optional
    /// - Note: hideAfter is in seconds
    /// - Note: retryClosure is a closure that will be executed when the user taps the retry button
    /// - Note: retryClosure is only applicable when hideAfter is not nil

    func showSnackBar(_ model: CBSnackBarView.ViewModel,
                      _ hideAfter: Double? = nil,
                      _ retryClosure: (() -> Void)? = nil)
    {
        let snackBar = CBSnackBarView(model)
        if let retryClosure = retryClosure {
            snackBar.setConfirmClosure(retryClosure)
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.endEditing(true)
            UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                UIApplication.shared.keyWindow?.addSubview(snackBar)
                snackBar.pinToSuperview()
            }) { _ in
                guard let hideAfter = hideAfter else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + hideAfter) { [weak self] in
                    guard let self = self else { return }
                    UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        snackBar.removeFromSuperview()
                    }, completion: nil)
                }
            }
        }
    }

    // Get keyboard height
    /// - Parameters: notification
    /// - Returns: CGFloat
    /// - Usage: keyboardHeight(notification)

    func keyboardHeight(notification: NSNotification) -> CGFloat {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            return keyboardRectangle.height
        }
        return 0
    }
}
