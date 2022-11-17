import CoreData
import UIKit

class MainPageCoordinator: Coordinator {

    var childCoordinator: [Coordinator] = []

    unowned let navigationController: UINavigationController

    var application: Application

    required init(navigationController: UINavigationController, application: Application) {
        self.navigationController = navigationController
        self.application = application
    }

    func start() {
        let mainViewController: MainViewController = MainViewController()
        let viewModel: MainPageViewModel = MainPageViewModel(application: application)
        viewModel.application.emojiService = application.emojiService
        viewModel.application.avatarService = application.avatarService
        mainViewController.viewModel = viewModel
        mainViewController.delegate = self
        self.navigationController.viewControllers = [mainViewController]

    }
}

extension MainPageCoordinator: MainViewControllerDelegate {

    func navigateToEmojiList() {
        let emojisListCoordinator = EmojisListCoordinator(navigationController: navigationController,
                                                          emojiService: application.emojiService)
        emojisListCoordinator.delegate = self
        childCoordinator.append(emojisListCoordinator)
        emojisListCoordinator.start()

    }

    func navigateToAvatarList() {
        let avatarListCoordinator = AvatarListCoordinator(navigationController: navigationController,
                                                          avatarService: application.avatarService)
        avatarListCoordinator.delegate = self
        childCoordinator.append(avatarListCoordinator)
        avatarListCoordinator.start()
    }

    func navigateToAppleRepos() {
        let appleReposListCoordinator = AppleReposListCoordinator(navigationController: navigationController)
        appleReposListCoordinator.delegate = self
        childCoordinator.append(appleReposListCoordinator)
        appleReposListCoordinator.start()
    }
}

extension MainPageCoordinator: BackToMainViewControllerDelegate {
    func navigateBackToMainPage() {
        childCoordinator.removeLast()
    }
}

protocol BackToMainViewControllerDelegate: AnyObject {
    func navigateBackToMainPage()
}

public protocol MainViewControllerDelegate: AnyObject {
    func navigateToEmojiList()
    func navigateToAvatarList()
    func navigateToAppleRepos()
}
