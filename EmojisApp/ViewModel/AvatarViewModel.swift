import Foundation
import UIKit.UIImage

public class AvatarViewModel {
    var avatarService: AvatarService?

    var avatarList: Box<[Avatar]?> = Box(nil)

    init(avatarService: AvatarService) {
        self.avatarService = avatarService
    }

    func getAvatar() {
        avatarService?.fetchAvatarList({ (result: [Avatar]) in
            self.avatarList.value = result
        })
    }

    func deleteAvatar(avatar: Avatar, at index: Int) {
        avatarService?.deleteAvatar(avatarToDelete: avatar)
        avatarList.value?.remove(at: index)
    }
}
