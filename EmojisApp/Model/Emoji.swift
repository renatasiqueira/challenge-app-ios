import UIKit

struct Emoji: Codable, CustomStringConvertible {
    var name: String
    var emojiUrl: URL
    
    var description: String {
        "\(name): \(emojiUrl)"
    }
}

extension Emoji: Comparable {
    static func < (lhs: Emoji, rhs: Emoji) -> Bool {
        lhs.name < rhs.name
    }
}
