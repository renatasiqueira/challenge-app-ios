import Foundation
import CoreData
import RxSwift

class LiveAvatarService: AvatarService {
 
    private var networkManager: NetworkManager = .init()
    private var persistence: PersistenceAvatar {
        return .init(persistentContainer: persistentContainer)
    }
    let disposeBag = DisposeBag()
    private var persistentContainer: NSPersistentContainer
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    var avatars: [Avatar] = []

    func fetchAvatarList() -> Single<[Avatar]> {
        persistence.fetchAvatarData()
    }

    func getAvatar(avatarName: String) -> Observable<Avatar> {

        persistence.checkAvatarList(avatarName: avatarName)
        .flatMap({ avatars -> Observable<Avatar> in
            guard
                let avatars = avatars else {
                return self.networkManager.rx.executeNetworkCall(AvatarAPI.getAvatars(avatarName))
                    .do { (result: Avatar) in
                        self.persistence.saveAvatar(currentAvatar: result).subscribe(onError: { error in
                            print("Error saving Avatar from API call: /(error)")
                        })
                        .disposed(by: self.disposeBag)
                    }
                    .asObservable()
            }
            return Observable.just(avatars)
        })
    }

    func deleteAvatar(_ avatarToDelete: Avatar) -> Completable {
        persistence.delete(avatarObject: avatarToDelete)
    }
}

