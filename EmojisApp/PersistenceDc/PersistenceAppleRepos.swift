import CoreData
import UIKit

class PersistenceAppleRepos {
    var persistenceAppleReposList: [NSManagedObject] = []

    var appDelegate: AppDelegate

    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
    }

}
