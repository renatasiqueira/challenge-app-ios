import UIKit
import CoreData

class PersistenceAvatar {
    var avatarsPersistenceList: [NSManagedObject] = []

    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func saveAvatar(currentAvatar: Avatar) {

        DispatchQueue.main.async {
            let managedContext = self.persistentContainer.viewContext

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

    func fetchAvatarData(_ resultHandler: @escaping ([Avatar]) -> Void) {
        var array: [NSManagedObject]
        var avatarArray: [Avatar]

        let managedContext = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AvatarEntity")

        do {
            array = try managedContext.fetch(fetchRequest)
            avatarArray = array.compactMap({ item -> Avatar? in
                item.toAvatar()
            })
            resultHandler(avatarArray)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")

        }
    }

    func checkAvatarList(login: String, _ resultHandler: @escaping(Result<[Avatar], Error>) -> Void) {

        var avatar: [Avatar]

        let managedContext = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>.init(entityName: "AvatarEntity")
        fetchRequest.predicate = NSPredicate(format: "login ==[cd] %@", login)

        do {
            let matchAvatar = try managedContext.fetch(fetchRequest)
            avatar = matchAvatar.compactMap({ item -> Avatar? in
                return item.toAvatar()
            })
            resultHandler(.success(avatar))
        } catch {
            print(error)
            resultHandler(.failure(error))
        }

    }

    func delete(avatarObject: Avatar) {

        let managedContext = persistentContainer.viewContext

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
