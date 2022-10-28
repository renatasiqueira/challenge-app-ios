import Foundation
import CoreData
import UIKit

class LiveEmojiStorage: EmojiService {

    var emojis: [Emoji] = []

    private var networkManager: NetworkManager = .init()
    private let persistenceEmoji: PersistenceEmojis

    
    init(persistentContainer: NSPersistentContainer) {
        persistenceEmoji = .init(persistenceContainer: persistentContainer)
    }
    
    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        var fetchEmojis: [NSManagedObject] = []
        fetchEmojis = persistenceEmoji.loadData()

        if !fetchEmojis.isEmpty {
            let emojisList = fetchEmojis.compactMap({ item -> Emoji? in
                guard let itemName = item.value(forKey: "name") as? String else {return nil}
                guard let itemUrl = item.value(forKey: "url") as? URL else {return nil}
                return Emoji(name: itemName, emojiUrl: itemUrl)
            })

            print(emojis.count)
            resultHandler(.success(emojis))
        } else {
            networkManager.executeNetworkCall(EmojiAPI.getEmojis) { (result: Result< EmojisAPICALLResult, Error>) in
                switch result {
                case .success(let success):
                    resultHandler(.success(success.emojis))
                    print("Success: \(success)")

                case .failure(let failure):
                    print("ErrorNetworkCall: \(failure)")
                }
            }
        }
    }
}
protocol EmojiPresenter: EmojiStorageDelegate {
    var emojiService: EmojiService? { get set }
}
