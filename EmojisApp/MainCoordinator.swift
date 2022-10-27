import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var avatarService: AvatarService?
    var navigationController: UINavigationController?
    var emojiService: EmojiService?
    var appleReposService: AppleReposService?
    
    var liveAvatarStorage: LiveAvatarStorage = .init()
    
    
    init(emojiService: EmojiService, avatarService: AvatarService, appleReposService: AppleReposService) {
        self.emojiService = emojiService
        
        self.avatarService = avatarService
        
        self.appleReposService = appleReposService
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
            let vc = AppleReposViewController()
            vc.coordinator = self
            vc.appleReposService = appleReposService
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        let vc = MainViewController()
        vc.coordinator = self
        vc.emojiService = emojiService
        vc.avatarService = liveAvatarStorage
        // vc.appleReposService = appleReposService
        navigationController?.setViewControllers([vc], animated: false)
    }
    
}

//extension MainCoordinator: EmojiStorageDelegate {
//    func emojiListUpdated() {
//        navigationController?.viewControllers.forEach {
//            ($0 as? EmojiPresenter)?.emojiListUpdated()
//        }
//    }
//}
//
//extension MainCoordinator: AvatarStorageDelegate {
//    func avatarListUpdated() {
//        navigationController?.viewControllers.forEach {
//            ($0 as? AvatarPresenter)?.avatarListUpdated()
//        }
//    }
//}
