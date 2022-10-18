import UIKit
import CoreData
import Alamofire


class PersistenceAvatar {
    var persistenceAvatarList: [NSManagedObject] = []
    var appDelegate: AppDelegate
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
    }
    
    
    func checkAvatarList(searchText: String, _ resultHandler: @escaping(Result<[NSManagedObject], Error>) -> Void) {
        
        let managedContext = self.appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")
        
        fetchRequest.predicate = NSPredicate(format: "login ==[cd] %@", searchText)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            resultHandler(.success(result))
        } catch {
            print(error)
            resultHandler(.failure(error))
        }
        
    }
    
    func persist(currentAvatar: Avatar) {
        
        let managedContext = self.appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "AvatarEntity", in: managedContext)!
        
        let avatar = NSManagedObject(entity: entity, insertInto: managedContext)
        
        avatar.setValue(currentAvatar.login, forKeyPath: "login")
        avatar.setValue(currentAvatar.avatarUrl.absoluteString, forKeyPath: "avatarUrl")
        avatar.setValue(currentAvatar.id, forKeyPath: "id")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchAvatarData(_ resultHandler: @escaping ([NSManagedObject]) -> Void){
        var array: [NSManagedObject]
        //        guard let appDelegate =
        //                UIApplication.shared.delegate as? AppDelegate else {
        //            return
        //        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")
        
        do {
            array = try managedContext.fetch(fetchRequest)
            resultHandler(array)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
        }
    }
    
    
}


