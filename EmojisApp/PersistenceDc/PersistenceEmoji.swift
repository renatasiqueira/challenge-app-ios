import CoreData
import UIKit

class PersistenceDc {
    var persistenceEmojis: [NSManagedObject] = []
    
    func saveEmojisList(name: String, url: String) {
        
        DispatchQueue.main.async {
            
            //1 - Pull up the application delegate and grab a reference to its persistent container to get your hands on its NSManagedObjectContext.
            
            guard let appDelegate =
                    UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext =
            appDelegate.persistentContainer.viewContext
            
            // 2 - This is what you do here to fetch all Emojis entities.
            let emojiEntity =
            NSEntityDescription.emojiEntity(forPersistenceEmoji: "PersistenceEmoji",
                                       in: managedContext)!
            
            let managedEmoji = NSManagedObject(emojiEntity: emojiEntity,
                                               insertInto: managedContext)
            
            managedEmoji.setValue(name, forKeyPath: "name")
            managedEmoji.setValue(url, forKey: "url")
            
            // 3 - Hand the request over to the managed object context to do the heavy lifting. managedEmojis returns an array of managed objects meeting the criteria specified by the fetch request.
            do {
                try managedContext.save()
                self.persistenceEmojis.append(managedEmoji)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
    
    func loadData() -> [NSManagedObject] {
        var array: [NSManagedObject] = []
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return array
        }
        
        let managedEmoji =
        appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "PersistenceEmoji")
        
        //3
        do {
            array = try managedEmoji.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return array
    }
}
