//
//  EmojisListCoordinator.swift
//  EmojisApp
//
//  Created by Renata Siqueira on 10/11/2022.
//

import Foundation
import UIKit
import CoreData

class EmojisListCoordinator: Coordinator {

    var childCoordinator: [Coordinator] = []
    let navigationController: UINavigationController
    weak var delegate: BackToMainViewControllerDelegate?
    var viewModel: EmojisViewModel?
    var emojiService: EmojiService?

    required init(navigationController: UINavigationController, emojiService: EmojiService) {
        self.navigationController = navigationController
        self.emojiService = emojiService
    }

    func start() {
        let viewModel = EmojisViewModel()
        viewModel.emojiService = emojiService

        let emojisListViewController: EmojisListViewController = EmojisListViewController()
        emojisListViewController.delegate = self
        emojisListViewController.viewModel = viewModel
        self.navigationController.pushViewController(emojisListViewController, animated: true)

    }
}

extension EmojisListCoordinator: SendBackDelegate {
    func navigateToMainPage() {
        self.delegate?.navigateBackToMainPage()
    }
}
