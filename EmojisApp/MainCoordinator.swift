import Foundation
import UIKit

class MainCoordinator: Coordinator, EmojiPresenter, AvatarPresenter {
    
    var avatarStorage: AvatarStorage?
    var navigationController: UINavigationController?
    var emojiStorage: EmojiStorage?
    
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
            var vc: UIViewController & Coordinating = AvatarListViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .appleReposButton:
            var vc: UIViewController & Coordinating = AvatarListViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
    
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
            func avatarListUpdate() {
                navigationController?.viewControllers.forEach{
                    ($0 as? AvatarPresenter)?.avatarListUpdate()
                }
            }
        }
    }
}
