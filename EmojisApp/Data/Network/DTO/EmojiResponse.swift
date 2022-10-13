import Foundation


struct EmojisAPICALLResult: Decodable {
    var emojis: [Emoji] = []
    let persistenceEmoji: PersistenceEmojis = .init()
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let emojisAsDictionary = try container.decode([String: String].self)
        emojis = emojisAsDictionary.map { (key: String, value: String) in
            persistenceEmoji.saveEmojisList(name: key, url: value)
            return Emoji(name: key, emojiUrl: URL(string: value)!)
        }
    }
}
