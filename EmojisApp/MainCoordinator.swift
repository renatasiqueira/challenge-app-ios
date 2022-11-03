import Foundation
import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController?
    var mainViewModel: MainViewModel?
    var emojisViewModel: EmojisViewModel?
    var avatarViewModel: AvatarViewModel?
    var appleReposViewModel: AppleReposViewModel?

    var application: Application = .init()

    init(emojiService: EmojiService, avatarService: AvatarService, appleReposService: AppleReposService) {
        self.appleReposViewModel = AppleReposViewModel(appleReposService: appleReposService)
        self.avatarViewModel = AvatarViewModel(avatarService: avatarService)
        self.emojisViewModel = EmojisViewModel(emojiService: emojiService)
        self.mainViewModel = MainViewModel(emojiService: emojiService, avatarService: avatarService)


    }
    func eventOccurred(with type: Event) {
        switch type {
        case .emojisListButton:
            let viewController = EmojisListViewController()
            viewController.coordinator = self
            viewController.viewModel = emojisViewModel
            navigationController?.pushViewController(viewController, animated: true)
        case .avatarListButton:
            let viewController = AvatarsListViewController()
            viewController.coordinator = self
            viewController.viewModel = avatarViewModel
            navigationController?.pushViewController(viewController, animated: true)
        case .appleReposButton:
            let viewController = AppleReposViewController()
            viewController.coordinator = self
            viewController.viewModel = appleReposViewModel
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func start() {
        let viewController = MainViewController()
        viewController.coordinator = self
        viewController.viewModel = mainViewModel
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
