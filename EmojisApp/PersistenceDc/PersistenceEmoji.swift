import CoreData
import UIKit

class PersistenceEmojis {
    var persistenceEmojisList: [NSManagedObject] = []
    
    func saveEmojisList(name: String, url: String) {
        
        DispatchQueue.main.async {
            
            //1
            
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
    
        //1 - Pull up the application delegate and grab a reference to its persistent container to get your hands on its NSManagedObjectContext.
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return array
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2 - NSFetchRequest is the class responsible for fetching from Core Data. This is what you do here to fetch all Emojis entities.
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmojiEntity")
        
        
        // 3 - Hand the request over to the managed object context to do the heavy lifting. managedEmojis returns an array of managed objects meeting the criteria specified by the fetch request.
        do {
            array = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return array
    }
}
