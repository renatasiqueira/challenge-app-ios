import Foundation
import CoreData
import UIKit

class LiveEmojiStorage: EmojiService {

    var emojisList: [Emoji] = []

    private var networkManager: NetworkManager = .init()
    private let persistenceEmoji: PersistenceEmojis = .init()

    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        var fetchEmojis: [NSManagedObject] = []
        fetchEmojis = persistenceEmoji.loadData()

        if !fetchEmojis.isEmpty {
            let emojisList = fetchEmojis.compactMap({ item -> Emoji? in
                guard let itemName = item.value(forKey: "name") as? String else {return nil}
                guard let itemUrlString = item.value(forKey: "url") as? String else {return nil}
                guard let itemUrl = URL(string: itemUrlString) else { return nil }
                return Emoji(name: itemName, emojiUrl: itemUrl)
            })

            print(emojisList.count)
            resultHandler(.success(emojisList))
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
