import UIKit

class AppleReposViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        title = "Apple Repos"

        // Do any additional setup after loading the view.
    }
   
}
