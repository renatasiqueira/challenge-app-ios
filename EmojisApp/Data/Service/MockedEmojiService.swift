import UIKit
import RxSwift

class MockedEmojiService: EmojiService {

    private var mockedEmojis: MockedEmojiService = .init()

    var emojis: [Emoji] = []

    func getEmojis() -> Single<[Emoji]> {
        return Single<[Emoji]>.create { [weak self] single in
            guard let self = self else { return Disposables.create() }

            single(.success(self.mockedEmojis.emojis))
            return Disposables.create()
        }
    }
}
