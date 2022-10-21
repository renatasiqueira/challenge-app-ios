import UIKit

struct AppleRepos: Decodable {
    var id: Int
    var fullName: String
    var isPrivate: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case isPrivate = "private"
    }
}

