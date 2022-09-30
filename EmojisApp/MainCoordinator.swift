import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccurred(with type: Event) {
        switch type {
        case .emojisListButton:
            var vc: UIViewController & Coordinating = EmojisListViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .randomEmojisButton:
            var vc: UIViewController & Coordinating = RandomEmojisViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .avatarListButton:
            var vc: UIViewController & Coordinating = AvatarListViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .appleReposButton:
            var vc: UIViewController & Coordinating = AppleReposViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .searchButton:
            var vc: UIViewController & Coordinating = SearchButtonViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
        }
    
    func start() {
        var vc: UIViewController & Coordinating = MainViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
        
    }
}
