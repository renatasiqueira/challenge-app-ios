//
//  AvatarListCoordinator.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 10/11/2022.
//

import Foundation
import UIKit
import CoreData

class AvatarListCoordinator: Coordinator {

    var childCoordinator: [Coordinator] = []
    unowned let navigationController: UINavigationController
    weak var delegate: BackToMainViewControllerDelegate?
    var avatarViewModel: AvatarViewModel?
    var avatarService: AvatarService?

    required init(navigationController: UINavigationController, avatarService: AvatarService) {
        self.navigationController = navigationController
        self.avatarService = avatarService
    }

    func start() {
        let viewModel = AvatarViewModel()
        viewModel.avatarService = avatarService

        let avatarsListViewController: AvatarsListViewController = AvatarsListViewController()
        avatarsListViewController.delegate = self
        avatarsListViewController.viewModel = viewModel

        self.navigationController.pushViewController(avatarsListViewController, animated: true)
    }

}

extension AvatarListCoordinator: SendBackDelegate {
    func navigateToMainPage() {
        self.delegate?.navigateBackToMainPage()
    }
}
