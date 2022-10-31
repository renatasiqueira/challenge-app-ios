import UIKit
import CoreData

class PersistenceAvatar {
    var persistenceAvatarList: [NSManagedObject] = []
    var application: Application = .init()

    let managedContext: NSManagedObjectContext?

    init() {
        managedContext = application.persistentContainer.viewContext
    }

    func checkAvatarList(searchText: String, _ resultHandler: @escaping(Result<[NSManagedObject], Error>) -> Void) {

        guard let managedContext = managedContext else {
            return
        }

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

        DispatchQueue.main.async {
            guard let managedContext = self.managedContext else {
                return
            }

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

    }
    func fetchAvatarData(_ resultHandler: @escaping ([NSManagedObject]) -> Void) {
        var array: [NSManagedObject]

        guard let managedContext = managedContext else {
            return
        }

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")

        do {
            array = try managedContext.fetch(fetchRequest)
            resultHandler(array)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")

        }
    }

    func delete(avatarObject: Avatar) {

        guard let managedContext = managedContext else {
            return
        }

        let fetchRequest = NSFetchRequest<NSManagedObject>.init(entityName: "AvatarEntity")
        fetchRequest.predicate = NSPredicate(format: "login = %@", avatarObject.login)

        do {
            let avatarToDelete = try managedContext.fetch(fetchRequest)
            if avatarToDelete.count == 1 {
                guard let avatar = avatarToDelete.first else { return }
                managedContext.delete(avatar)
                try managedContext.save()
            }

        } catch let error as NSError {
            print("Error deleting Avatar: \(error)")
        }
    }

}
