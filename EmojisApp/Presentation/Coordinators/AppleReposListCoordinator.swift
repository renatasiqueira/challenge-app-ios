import Foundation
import UIKit
import CoreData

class AppleReposListCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    weak var delegate: BackToMainViewControllerDelegate?
    
    var reposViewModel: AppleReposView?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let appleReposViewController: AppleReposViewController = AppleReposViewController()
        appleReposViewController.delegate = self
        let appleReposService: AppleReposService = MockAppleReposService()
        appleReposViewController.viewModel = AppleReposViewModel(appleReposService: appleReposService)
        self.navigationController.pushViewController(appleReposViewController, animated: true)
    }
    
}

extension AppleReposListCoordinator: SendBackDelegate {
    func navigateToMainPage() {
        self.delegate?.navigateBackToMainPage()
    }
}
