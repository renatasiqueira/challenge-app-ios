import CoreData
import UIKit

class PersistenceEmojis {
    var persistenceEmojisList: [NSManagedObject] = []

    func saveEmojisList(name: String, url: String) {

        DispatchQueue.main.async {

            // 1

            guard let appDelegate =
                    UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            let managedContext =
            appDelegate.persistentContainer.viewContext

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

        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return array
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmojiEntity")

        do {
            array = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return array
    }
}
