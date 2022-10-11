import UIKit

class AppleReposViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appColor(name: .primary)
        view.tintColor = .appColor(name: .secondary)
        title = "Apple Repos"

        // Do any additional setup after loading the view.
    }
   
}
