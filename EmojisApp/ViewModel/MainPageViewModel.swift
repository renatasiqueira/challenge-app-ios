import Foundation
import UIKit
import RxSwift

public class MainPageViewModel {

    var application: Application

    let backgroundScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "MainPageViewModel.backgroundScheduler")

    private var rxEmojiImageUrl: BehaviorSubject<URL?> = BehaviorSubject(value: nil)
    private var _rxEmojiImage: BehaviorSubject<UIImage?> = BehaviorSubject(value: nil)
    var rxEmojiImage: Observable<UIImage?> { _rxEmojiImage.asObservable() }

    //    private var searchQuery: Box<String?> = Box(nil)

    private var searchAvatarName: PublishSubject<String> = PublishSubject()
    private var _searchAvatar: PublishSubject<UIImage?> = PublishSubject()
    var searchAvatar: Observable<UIImage?> { _searchAvatar.asObservable() }

    let disposeBag = DisposeBag()
    var ongoingRequests: [String: Observable<UIImage?>] = [:]

    init(application: Application) {
        self.application = application

        //        searchQuery.bind { [weak self] _ in
        //            self?.searchAvatar()
        //        }

        rxEmojiImageUrl
            .debug("rxEmojiImageUrl")
            .flatMap({ [weak self] url -> Observable<UIImage?> in
                guard let self = self else { return Observable.never() }
                let observable = self.ongoingRequests[url?.absoluteString ?? ""]
                if observable == nil {
                    let observableUrl = self.dataOfUrl(url).share(replay: 1, scope: .forever)
                    self.ongoingRequests[url?.absoluteString ?? ""] = observableUrl
                }

                guard let observable = self.ongoingRequests[url?.absoluteString ?? ""] else { return Observable.never() }

                return observable
            })
            .debug("rxEmojiImage")
            .subscribe(_rxEmojiImage)
            .disposed(by: disposeBag)

        searchAvatarName
            .debug("rxSearchAvatarName")
            .flatMap({ avatarName in
                return application.avatarService.getAvatar(avatarName: avatarName)
            })
            .flatMap({ avatar -> Observable<UIImage?> in
                return self.dataOfUrl(avatar.avatarUrl)
            })
            .debug("searchAvatar")
            .subscribe(_searchAvatar)
            .disposed(by: disposeBag)

        print("end init")
    }

func getRandomEmoji() {

    application.emojiService.getEmojis()
        .observe(on: MainScheduler.instance)
        .subscribe(
            onSuccess: { [weak self] emojis in
                guard
                    let self = self
                else { return }
                let randomUrl = emojis.randomElement()?.emojiUrl
                self.rxEmojiImageUrl.onNext(randomUrl)
            }, onFailure: { error in
                print("[getRandom-ViewModel] - Disposed")
            })
        .disposed(by: disposeBag)
}

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

    func getAvatar(avatarName: String) {
        self.searchAvatarName.onNext(avatarName)
}

}
