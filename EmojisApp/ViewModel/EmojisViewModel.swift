import Foundation
import UIKit
//
import RxSwift

class EmojisViewModel {
    var emojiService: EmojiService?
    //    var emojisList: Box<[Emoji]?> = Box(nil)
    
    let backgroundScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "MainPageViewModel.backgroundScheduler")
    
    let disposeBag = DisposeBag()
    var ongoingRequests: [String: Observable<UIImage>] = [:]

    init(emojiService: EmojiService) {
        self.emojiService = emojiService
    }
    
    func imageAtUrl(url: URL) -> Observable<UIImage> {
        Observable<UIImage>
            .deferred { [weak self] in
                guard let self = self else { return Observable.never() }
                let observable = self.ongoingRequests[url.absoluteString]
                
                if observable == nil {
                    self.ongoingRequests[url.absoluteString] = self.dataOfUrl(url)
                }
                guard let observable = self.ongoingRequests[url.absoluteString] else { return Observable.never() }
                return observable
            }
            .subscribe(on: MainScheduler.instance)
    }
    
    func dataOfUrl(_ url: URL?) -> Observable<UIImage> {
        Observable<URL?>.never().startWith(url)
            .observe(on: backgroundScheduler)
            .flatMapLatest { url throws -> Observable<UIImage> in
                guard let url = url else { return Observable.just(UIImage()) }
                return downloadTask(url: url)
            }
            .share(replay: 1, scope: .forever)
            .observe(on: MainScheduler.instance)
        
    }
    
    func getEmojis() -> Single<[Emoji]> {
        guard let emojiService = emojiService else {
            return Single<[Emoji]>.never()
        }
        
        return emojiService.getEmojis()
            .flatMap({ result in
                let emojis: [Emoji] = result.sorted()
                return Single<[Emoji]>.just(emojis)
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
