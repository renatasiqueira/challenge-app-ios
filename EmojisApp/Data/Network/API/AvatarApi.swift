import Foundation

enum AvatarAPI {
    case getAvatars(String)
}

extension AvatarAPI: APIProtocol {
    var headers: [String : String] {
        ["Contect-Type": "application/json"]
    }
    
    var url: URL {
        switch self {
        case .getAvatars(let name):
            return URL(string: "https://api.github.com/users/\(name)")!
        }
    }
    
    var method: Method {
        switch self {
        case .getAvatars:
            return .get
        }
    }
}

