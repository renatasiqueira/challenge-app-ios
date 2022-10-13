import UIKit
import CoreData


class PersistenceAvatar {
    var persistenceAvatarList: [NSManagedObject] = []
    
    func saveAvatarList(name: String, url: String, avatar: String) {
        
        DispatchQueue.main.async {
            guard let appDelegate =
                    UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext =
            appDelegate.persistentContainer.viewContext
            
            let avatarEntity =
            NSEntityDescription.entity(forEntityName: "AvatarEntity",
                                       in: managedContext)!
            // 3
            let managedAvatar = NSManagedObject(entity: avatarEntity,
                                                insertInto: managedContext)
            
            managedAvatar.setValue(name, forKeyPath: "name")
            managedAvatar.setValue(url, forKey: "url")
            
            // 4
            do {
                try managedContext.save()
                self.persistenceAvatarList.append(avatar)
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
        
    }
}


