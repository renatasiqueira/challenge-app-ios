import UIKit

class MockedEmojiService: EmojiService {

   // weak var delegate: EmojiStorageDelegate?

    private var mockedEmojis: MockedEmojiService = .init()

    var emojis: [Emoji] = []

    func getEmojisList(_ resultHandler: @escaping (Result<[Emoji], Error>) -> Void) {
        emojis = mockedEmojis.emojis
        resultHandler(.success(emojis))
    }
}
