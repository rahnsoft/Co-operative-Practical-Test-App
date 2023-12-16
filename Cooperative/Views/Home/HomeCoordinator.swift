//
//  HomeCoordinator.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import CooperativeDependencyInjection
import CooperativeDomain
import UIKit

class HomeCoordinator {
    private let window: UIWindow?
    private var navigationController: UINavigationController
    private var homeViewController: HomeViewController?
    private var homeViewModel: HomeViewModel

    init(_ window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        homeViewModel = DependencyInjection.shared.resolve(HomeViewModel.self)
    }

    func start() {
        homeViewModel.setCoordinator(self)
        let homeViewController = HomeViewController(homeViewModel)
        self.homeViewController = homeViewController
        navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.isNavigationBarHidden = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func logout() {
        guard let window = appDelegate.window else {
            return
        }
        LoginCoordinator(window).start()
    }
}
