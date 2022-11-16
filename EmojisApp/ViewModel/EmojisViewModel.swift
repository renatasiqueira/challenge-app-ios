import Foundation

public class EmojisViewModel {
    var emojiService: EmojiService?

    var emojisList: Box<[Emoji]?> = Box(nil)

//    init(emojiService: EmojiService) {
//        self.emojiService = emojiService
//    }

    func getEmojis() {
        emojiService?.getEmojisList({ (result: Result<[Emoji], Error>) in
            switch result {
            case .success(var sucess):
                sucess.sort()
                self.emojisList.value = sucess
            case .failure(let failure):
                print("Error: \(failure)")
            }
        })
    }

}
