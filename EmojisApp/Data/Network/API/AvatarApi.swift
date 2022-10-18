import Foundation

enum AvatarAPI {
    case getAvatars
    case postAvatar
}

extension AvatarAPI: APIProtocol {
    var url: URL {
        get {
            return URL(string: "https://api.github.com/users")!
        }
        set(newValue) {
        }
    }
    
    var method: Method {
        switch self {
        case .getAvatars:
            return .get
        case .postAvatar:
            return .post
        }
    }
    
    var headers: [String: String] {
        ["Contect-Type": "application/json"]
    }
}
