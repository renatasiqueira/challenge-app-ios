import Foundation
import UIKit

enum Event {
    case emojisListButton
    // case randomEmojisButton
    case avatarListButton
    case appleReposButton
    // case searchButton
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }

    func eventOccurred(with type: Event)

    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

protocol EmojiStorageDelegate: AnyObject {
    func emojiListUpdated()
}

protocol AvatarStorageDelegate: AnyObject {
    func avatarListUpdated()
}

protocol ReposStorageDelegate: AnyObject {
    func reposListUpdated()
}
