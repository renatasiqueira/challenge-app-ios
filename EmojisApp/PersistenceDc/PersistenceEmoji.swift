import CoreData
import UIKit

class PersistenceEmojis {
    var persistenceEmojisList: [NSManagedObject] = []
    var application: Application = .init()

    func saveEmojisList(name: String, url: String) {

        DispatchQueue.main.async {

            // 1

            let managedContext = self.application.persistentContainer.viewContext

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

        let managedContext = application.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmojiEntity")

        do {
            array = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return array
    }
}
