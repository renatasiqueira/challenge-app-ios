import Foundation

class LiveEmojiStorage: EmojiService {
    
    var emojis: [Emoji] = []
    weak var delegate: EmojiStorageDelegate?
    
    private var networkManager: NetworkManager = .init()
    
    init() {
        
    }
    
    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        networkManager.executeNetworkCall(EmojiAPI.getEmojis) { (result: Result< EmojisAPICALLResult, Error>) in
            switch result {
            case .success(let success):
                resultHandler(.success(success.emojis))
                print("Success: \(success)")
                
            case .failure(let failure):
               print("Error: \(failure)")
            }
        }
    }
    
    
}

protocol EmojiPresenter: EmojiStorageDelegate {
    var emojiService: EmojiService? { get set }
}


/*
 protocol EmojiStorage {
 var delegate: EmojiStorageDelegate? { get set }
 var emojis: [Emoji] { get set }
 }
 */
