import UIKit
import RxSwift

protocol AvatarService {
    func getAvatar(avatarName: String) -> Observable<Avatar>
    func fetchAvatarList() -> Single<[Avatar]>
    func deleteAvatar(_ avatarToDelete: Avatar) -> Completable
}
