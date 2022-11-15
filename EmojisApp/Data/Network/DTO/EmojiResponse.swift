import Foundation

struct EmojisAPICALLResult: Decodable {
    var emojis: [Emoji] = []

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let emojisAsDictionary = try container.decode([String: String].self)
        emojis = emojisAsDictionary.map { (key: String, value: String) in
        return Emoji(name: key, emojiUrl: URL(string: value)!)
        }
    }
}
