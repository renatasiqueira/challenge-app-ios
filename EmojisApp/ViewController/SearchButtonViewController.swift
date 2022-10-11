import UIKit

class SearchButtonViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .systemGreen
        title = "Search"
    }

}
