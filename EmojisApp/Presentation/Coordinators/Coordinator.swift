import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    func start()
}
