import Foundation
import UIKit
//
import RxSwift

class EmojisViewModel {
    var emojiService: EmojiService?

    var emojisList: Box<[Emoji]?> = Box(nil)

    let backgroundScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "MainPageViewModel.backgroundScheduler")

    let disposeBag = DisposeBag()
    var ongoingRequests: [String: Observable<UIImage?>] = [:]

    func dataOfUrl(_ url: URL?) -> Observable<UIImage?> {
        Observable<URL?>.never().startWith(url)
            .observe(on: backgroundScheduler)
            .flatMapLatest { url throws -> Observable<Data> in
                guard let url = url else {
                    return Observable.just(Data())
                }
                guard let data = try? Data(contentsOf: url) else { return Observable.just(Data()) }
                return Observable.just(data)
            }
            .map {
                UIImage(data: $0) ?? nil
            }
            .observe(on: MainScheduler.instance)
            .debug("dataOfUrl")
    }

    func getEmojis() -> Single<[Emoji]> {
        guard let emojiService = emojiService else {
            return Single<[Emoji]>.error(ServiceError.cannotInstanciate)
        }

        return emojiService.getEmojis()
            .map({ emojisList in
                var emojis = emojisList
                emojis.sort()
                return emojis
            })
    }

}

func downloadTask(url: URL, placeholder: UIImage = UIImage()) -> Observable<UIImage> {
    guard let request = try? URLRequest(url: url) else { return Observable.just(placeholder) }
    return URLSession.shared.rx.response(request: request)
        .map { (response: HTTPURLResponse, data: Data) -> UIImage in
            guard
                response.statusCode == 200,
                let image = UIImage(data: data)
            else { return placeholder }
            return image
        }
}
