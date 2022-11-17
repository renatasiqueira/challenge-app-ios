import Foundation

struct EmojisApiCallResult: Decodable {
    var emojis: [Emoji] = []

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let emojisAsDictionary = try container.decode([String: String].self)
        emojis = emojisAsDictionary.map { (key: String, value: String) in
            guard let url = URL(string: value) else {
                fatalError("Cannot found URL")
            }
            return Emoji(name: key, emojiUrl: url)
        }
    }
}

