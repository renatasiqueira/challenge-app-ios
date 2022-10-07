import Foundation

enum AvatarAPI {
    case getAvatars
    case postAvatar
}

extension AvatarAPI: APIProtocol {
    var url: URL {
        URL(string: "")!
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
struct AvatarsAPICALLResult: Decodable {
    
}
