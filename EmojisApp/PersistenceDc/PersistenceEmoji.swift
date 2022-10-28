import CoreData
import UIKit

class PersistenceEmojis {
    var persistenceEmojisList: [NSManagedObject] = []
    var persistenceContainer: NSPersistentContainer

    init(persistenceContainer: NSPersistentContainer) {
        self.persistenceContainer = persistenceContainer
    }

    func saveEmojisList(name: String, url: String) {

        DispatchQueue.main.async {

            // 1

            let managedContext = self.persistenceContainer.viewContext

            // 2
            let entity =
            NSEntityDescription.entity(forEntityName: "EmojiEntity",
                                       in: managedContext)!
            // 3
            let managedEmoji = NSManagedObject(entity: entity,
                                               insertInto: managedContext)

            managedEmoji.setValue(name, forKeyPath: "name")
            managedEmoji.setValue(url, forKey: "url")

            // 4
            do {
                try managedContext.save()
                self.persistenceEmojisList.append(managedEmoji)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }

    }
    func loadData() -> [NSManagedObject] {
        var array: [NSManagedObject] = []

        let managedContext = self.persistenceContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmojiEntity")

        do {
            array = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return array
    }
}
