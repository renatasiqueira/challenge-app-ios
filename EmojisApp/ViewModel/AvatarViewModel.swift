import Foundation

public class AvatarViewModel {
    var avatarService: AvatarService?

    var avatarList: Box<[Avatar]?> = Box(nil)

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
