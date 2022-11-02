import Foundation
import UIKit

enum Event {
    case emojisListButton
    case avatarListButton
    case appleReposButton
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }

    func eventOccurred(with type: Event)

    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
