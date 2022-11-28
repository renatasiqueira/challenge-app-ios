import Foundation
import CoreData
import RxSwift

class LiveEmojiService: EmojiService {

    let disposeBag = DisposeBag()

    var emojisList: [Emoji] = []

    private var networkManager: NetworkManager = .init()

    private var persistence: PersistenceEmojis
    private var persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.persistence = PersistenceEmojis.init(persistentContainer: persistentContainer)
    }

    func getEmojis() -> Single<[Emoji]> {
        return persistence.loadData()
            .flatMap({ fetchedEmojis in
                if fetchedEmojis.isEmpty {
                    return self.networkManager.rx.executeNetworkCall(EmojiAPI.getEmojis)
                        .map { (emojiResult: EmojisApiCallResult) in
                            self.persistEmojis(emojis: emojiResult.emojis)
                            return emojiResult.emojis
                        }
                }
                return Single<[Emoji]>.just(fetchedEmojis)
            })
    }
    func persistEmojis(emojis: [Emoji]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            emojis.forEach { emojis in
                self.persistence.saveEmojisList(currentEmojis: emojis)
                    .subscribe(onError: { error in
                        print("Error: Emojis from API call here: \(error)")
                    })
                    .disposed(by: self.disposeBag)
            }
        }
    }
}
