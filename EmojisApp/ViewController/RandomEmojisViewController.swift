import UIKit

class RandomEmojisViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        title = "Random Emojis"

        // Do any additional setup after loading the view.
    }
}
