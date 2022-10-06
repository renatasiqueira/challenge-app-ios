import Foundation
import UIKit

class MainCoordinator: Coordinator, EmojiPresenter, AvatarPresenter {
    var avatarStorage: AvatarStorage?
    var navigationController: UINavigationController?
    var emojiStorage: EmojiStorage?
    
    //O avatar Storage só precisa de ser chamada quando se clica no avatars list button
    init(emojiStorage: EmojiStorage, avatarStorage: AvatarStorage) {
        self.emojiStorage = emojiStorage
        self.emojiStorage?.delegate = self
        
        self.avatarStorage = avatarStorage
        self.avatarStorage?.delegate = self
    }
    
    func eventOccurred(with type: Event) {
        switch type {
        case .emojisListButton:
            var vc: UIViewController & Coordinating & EmojiPresenter = EmojisListViewController()
            vc.coordinator = self
            vc.emojiStorage = emojiStorage
            navigationController?.pushViewController(vc, animated: true)
        case .avatarListButton:
            var vc: UIViewController & Coordinating & AvatarPresenter = AvatarsListViewController()
            vc.coordinator = self
            vc.avatarStorage = avatarStorage
            navigationController?.pushViewController(vc, animated: true)
        case .appleReposButton:
            var vc: UIViewController & Coordinating = AvatarsListViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        var vc: UIViewController & Coordinating & EmojiPresenter = MainViewController()
        vc.coordinator = self
        vc.emojiStorage = emojiStorage
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
