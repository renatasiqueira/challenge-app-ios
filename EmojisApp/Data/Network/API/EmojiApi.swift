import Foundation

enum EmojiAPI {
    case getEmojis
    case postEmoji
}

extension EmojiAPI: APIProtocol {

    var url: URL {
        URL(string: "\(Constants.baseURL)/emojis")!
    }

    var method: Method {
        switch self {
        case .getEmojis:
            return .get
        case .postEmoji:
            return .post
        }
    }

    var headers: [String: String] {
        ["Contect-Type": "application/json"]
    }
}
