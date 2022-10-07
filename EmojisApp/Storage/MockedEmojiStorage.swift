import UIKit


class MockedEmojiService: EmojiService {
   //var delegate: EmojiStorageDelegate?
    
    
    private var mockedEmojis: MockedEmojisService = .init()
    
    //var emojis: [Emoji] = []
    /*
    func getRandomEmojiUrl(_ resultUrl: @escaping (URL) -> Void) {
        emojis = mockedEmojis.emojis
        guard let url = emojis.randomElement()?.emojiUrl else { return }
        resultUrl(url)
        */
    func getEmojiList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void){
        
        resultHandler(.success([mockedEmojis.))
    }
    }
