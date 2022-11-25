import Foundation
import RxSwift

public class AvatarViewModel {
    var avatarService: AvatarService?

    var avatarList: Box<[Avatar]?> = Box(nil)

    func getAvatar() -> Single<[Avatar]> {
        guard let avatarService = avatarService else {
            return Single<[Avatar]>.error(ServiceError.cannotInstanciate)
        }
        return avatarService.fetchAvatarData()
    }

    func deleteAvatar(avatar: Avatar) -> Completable {
        guard let avatarService = avatarService else {
            return Completable.error(AvatarError.serviceNotAvailable)
        }
        return avatarService.deleteAvatar(avatarToDelete: avatar)
    }
}

