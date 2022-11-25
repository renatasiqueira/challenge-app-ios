import UIKit
import RxSwift

protocol EmojiService {
    func getEmojisList() -> Single<[Emoji]>
}
