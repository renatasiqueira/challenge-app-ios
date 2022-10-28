import Foundation
import CoreData

class LiveEmojiStorage: EmojiService {
    
    var emojis: [Emoji] = []
    //weak var delegate: EmojiStorageDelegate?
    
    private var networkManager: NetworkManager = .init()
    private var persistenceEmoji: PersistenceEmojis = .init()
    
    init() {
        
    }
    
    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        var fetchEmojis : [NSManagedObject] = []
        fetchEmojis = persistenceEmoji.loadData()

        if !fetchEmojis.isEmpty {
            let emojisList = fetchEmojis.map({
                item in
                return Emoji(name: item.value(forKey: "name") as! String, emojiUrl: URL(string: item.value(forKey: "url") as! String)!)
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

protocol EmojiPresenter: EmojiStorageDelegate {
    var emojiService: EmojiService? { get set }
}


