import CoreData
import UIKit

class PersistenceAppleRepos {
    var persistenceAppleReposList: [NSManagedObject] = []
    var persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
}
