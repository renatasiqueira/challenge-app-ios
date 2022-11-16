//
//  AppleReposListCoordinator.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 10/11/2022.
//

import Foundation
import UIKit
import CoreData

class AppleReposCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []

    unowned let navigationController: UINavigationController
    weak var delegate: BackToMainViewControllerDelegate?

    var reposViewModel: AppleReposView?

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let appleReposViewController: AppleReposViewController = AppleReposViewController()
        appleReposViewController.delegate = self
        let appleReposService: AppleReposService = MockAppleReposService()
        appleReposViewController.viewModel = AppleReposViewModel(appleReposService: appleReposService)
        self.navigationController.pushViewController(appleReposViewController, animated: true)
    }

}

extension AppleReposCoordinator: AppleReposViewControllerDelegate {
    func navigateToMainPage() {
         self.delegate?.navigateBackToMainPage()
    }
}
