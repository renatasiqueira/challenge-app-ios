import CoreData
import UIKit

class PersistenceEmojis {

    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func saveEmojisList(name: String, url: String) {

        DispatchQueue.main.async {

            // 1

            let managedContext = self.persistentContainer.viewContext

            // 2
            let entity =
            NSEntityDescription.entity(forEntityName: "EmojiEntity", in: managedContext)!
            // 3
            let managedEmoji = NSManagedObject(entity: entity, insertInto: managedContext)

            managedEmoji.setValue(name, forKeyPath: "name")
            managedEmoji.setValue(url, forKey: "url")

            // 4
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }

    }
    func loadData() -> [Emoji] {
        var array: [NSManagedObject] = []
        var emojisArray: [Emoji] = []

        let managedContext = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmojiEntity")

        do {
            array = try managedContext.fetch(fetchRequest)
            emojisArray = array.compactMap({ item -> Emoji? in
                item.toEmojis()
            })
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return emojisArray
    }
}
