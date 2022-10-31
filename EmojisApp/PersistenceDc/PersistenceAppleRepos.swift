import CoreData
import UIKit

class PersistenceAppleRepos {
    var persistenceAppleReposList: [NSManagedObject] = []
    var persistenceContainer: NSPersistentContainer

    init(persistenceContainer: NSPersistentContainer) {
        self.persistenceContainer = persistenceContainer
    }
}
