import UIKit


class MockedEmojiStorage: EmojiService {
        
    var delegate: EmojiStorageDelegate?
        
    private var mockedEmojis: MockedEmojisStorage = .init()
    
    var emojis: [Emoji] = []
    
    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        emojis = mockedEmojis.emoji
        resultHandler(.success(emojis))
    }
    }
