import UIKit

/*
 protocol EmojiService {
    //func getRandomEmojiUrl(_ resultUrl: @escaping (URL) -> Void)
    //var delegate: EmojiServiceDelegate? { get set }
    //var emojis: [Emoji] { get set }
    
    func getEmojiList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void)
}
*/

protocol EmojiService {
    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void)
}
