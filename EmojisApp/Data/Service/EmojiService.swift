import UIKit
import RxSwift

protocol EmojiService {
    func getEmojis() -> Single<[Emoji]>
}
