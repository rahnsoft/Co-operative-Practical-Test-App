//
//  HomeViewController.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import UIKit

class HomeViewController: BaseViewController {
    private var viewModel: HomeViewModel
    @IBOutlet var welcomeGreetingLabel: UILabel!
    @IBOutlet var logoutStackview: UIStackView!
    
    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ControllerIds.homeVCIdentifier.rawValue, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservables()
    }
    
    // Configure Observables
    func configureObservables() {
        viewModel.fetchUser()
            .subscribe(onSuccess: { [weak self] user in
                guard let self = self else { return }
                let username = user.firstName + " " + user.lastName
                let attributedWithTextColor: NSAttributedString = Strings.commonBankUserGreetings.localized(with: username).attributedStringWithColorAndBold([username], color: UIColor.cbThemeColor, boldWords: [username])

                welcomeGreetingLabel.attributedText = attributedWithTextColor
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.viewModel.handleError(error) {
                    _ = self.viewModel.fetchUser()
                }
            })
            .disposed(by: disposeBag)
        
        logoutStackview.isUserInteractionEnabled = true
        logoutStackview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logout)))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
     }
    
    // Logout function
    @objc func logout() {
        logoutStackview.isUserInteractionEnabled = false
        logoutStackview.alpha = 0.5
        viewModel.logout()
    }
}
