import UIKit

protocol EmojiService {
    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void)
}
