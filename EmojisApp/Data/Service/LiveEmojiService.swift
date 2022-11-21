import Foundation
import CoreData
import UIKit

class LiveEmojiService: EmojiService {

    var emojisList: [Emoji] = []

    private var networkManager: NetworkManager = .init()
    private var persistence: PersistenceEmojis {
        return .init(persistentContainer: persistentContainer)
    }
    private var persistentContainer: NSPersistentContainer
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    var emojis: [Emoji] = []

    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        var fetchEmojis: [Emoji] = []
        fetchEmojis = persistence.loadData()

        if !fetchEmojis.isEmpty {
            resultHandler(.success(fetchEmojis))
        } else {
            networkManager.executeNetworkCall(EmojiAPI.getEmojis) {[ weak self ] (result: Result<EmojisApiCallResult,
                                                                                  Error>) in
                guard let self = self else { return }
                switch result {
                case .success(let success):
                    success.emojis.forEach { emojis in
                        DispatchQueue.main.async { [ weak self ] in
                            guard let self = self else { return }
                            self.persistence.saveEmojisList(name: emojis.name, url: emojis.emojiUrl.absoluteString)
                        }
                    }
                    resultHandler(.success(success.emojis))
                case .failure(let failure):
                    print("ErrorNetworkCall: \(failure)")
                }
            }
        }
    }
}
