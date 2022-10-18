import Foundation
import UIKit

class MainCoordinator: Coordinator, EmojiPresenter {
    var avatarService: AvatarService?
    var navigationController: UINavigationController?
    var emojiService: EmojiService?
    
    var liveAvatarStorage: LiveAvatarStorage = .init()
    
    
    init(emojiService: EmojiService, avatarService: AvatarService) {
        self.emojiService = emojiService
    
        self.avatarService = avatarService
    }
    
    func eventOccurred(with type: Event) {
        switch type {
        case .emojisListButton:
            let vc = EmojisListViewController()
            vc.coordinator = self
            vc.emojiService = emojiService
            navigationController?.pushViewController(vc, animated: true)
        case .avatarListButton:
            let vc = AvatarsListViewController()
            vc.coordinator = self
            vc.avatarService = liveAvatarStorage
            navigationController?.pushViewController(vc, animated: true)
        case .appleReposButton:
            let vc = AvatarsListViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        let vc = MainViewController()
        vc.coordinator = self
        vc.emojiService = emojiService
        vc.avatarService = liveAvatarStorage
        navigationController?.setViewControllers([vc], animated: false)
    }
    
}

extension MainCoordinator: EmojiStorageDelegate {
    func emojiListUpdated() {
        navigationController?.viewControllers.forEach {
            ($0 as? EmojiPresenter)?.emojiListUpdated()
        }
    }
}

extension MainCoordinator: AvatarStorageDelegate {
    func avatarListUpdated() {
        navigationController?.viewControllers.forEach {
            ($0 as? AvatarPresenter)?.avatarListUpdated()
        }
    }
}
