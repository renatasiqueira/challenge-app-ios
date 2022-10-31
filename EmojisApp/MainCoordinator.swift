import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var avatarService: AvatarService?
    var navigationController: UINavigationController?
    var emojiService: EmojiService?
    var appleReposService: AppleReposService?
    var application: Application = .init()

    var liveAvatarStorage: LiveAvatarStorage = .init()

    init(emojiService: EmojiService, avatarService: AvatarService, appleReposService: AppleReposService) {
        self.emojiService = emojiService

        self.avatarService = avatarService

        self.appleReposService = appleReposService
    }

    func eventOccurred(with type: Event) {
        switch type {
        case .emojisListButton:
            let viewController = EmojisListViewController()
            viewController.coordinator = self
            viewController.emojiService = emojiService
            navigationController?.pushViewController(viewController, animated: true)
        case .avatarListButton:
            let viewController = AvatarsListViewController()
            viewController.coordinator = self
            viewController.avatarService = liveAvatarStorage
            navigationController?.pushViewController(viewController, animated: true)
        case .appleReposButton:
            let viewController = AppleReposViewController()
            viewController.coordinator = self
            viewController.appleReposService = appleReposService
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func start() {
        let viewController = MainViewController()
        viewController.coordinator = self
        viewController.emojiService = emojiService
        viewController.avatarService = liveAvatarStorage
        navigationController?.setViewControllers([viewController], animated: false)
    }
}
