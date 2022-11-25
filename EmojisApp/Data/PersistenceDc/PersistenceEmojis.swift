import CoreData
import UIKit
import RxSwift

class PersistenceEmojis {

    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func saveEmojisList(currentEmojis: Emoji) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else {
                completable(.error(PersistenceError.selfError))
                return Disposables.create {}
            }

            let managedContext = self.persistentContainer.viewContext

            let entity =
            NSEntityDescription.entity(forEntityName: "EmojiEntity", in: managedContext)!

            let managedEmoji = NSManagedObject(entity: entity, insertInto: managedContext)

            managedEmoji.setValue(currentEmojis.name, forKeyPath: "name")
            managedEmoji.setValue(currentEmojis.emojiUrl.absoluteString, forKey: "url")

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                completable(.error(PersistenceError.saveError))
                return Disposables.create {}
            }
            completable(.completed)
            return Disposables.create {}

        }

    }
    func loadData() -> Single<[Emoji]> {
        return Single<[Emoji]>.create { single in
            //        var array: [NSManagedObject] = []
            //        var emojisArray: [Emoji] = []
            
            let managedContext = self.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmojiEntity")

            guard let resultFetch = try? managedContext.fetch(fetchRequest)
            else {
                single(.failure(PersistenceError.fetchError))
                return Disposables.create {}
            }
            let result: [Emoji] = resultFetch.compactMap({ item -> Emoji? in
                item.toEmojis()
            })
            single(.success(result))
            return Disposables.create {}
        }

    }
}
