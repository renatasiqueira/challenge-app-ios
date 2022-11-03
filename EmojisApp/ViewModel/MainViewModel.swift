import Foundation
import UIKit.UIImage

public class MainViewModel {

    var emojiService: EmojiService?
    var avatarService: AvatarService?

    let emojiImageUrl: Box<URL?> = Box(nil)
    var searchQuery: Box<String?> = Box(nil)

    init(emojiService: EmojiService, avatarService: AvatarService) {
        self.emojiService = emojiService
        self.avatarService = avatarService

        searchQuery.bind { [weak self] _ in
            self?.searchAvatar()
        }
    }

    func getRandom() {
        emojiService?.getEmojisList { (result: Result<[Emoji], Error>) in
            switch result {
            case .success(let success):
                guard let url = success.randomElement()?.emojiUrl else { return }
                self.emojiImageUrl.value = url
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }
    private func searchAvatar() {
        guard let searchQuery = searchQuery.value else { return }

        avatarService?.getAvatar(searchText: searchQuery, { (result: Result<Avatar, Error>) in
            switch result {
            case .success(let success):
                let avatar = success.avatarUrl
                self.emojiImageUrl.value = avatar
            case .failure(let failure):
                print("Error: \(failure)")
            }
        })
    }
}
