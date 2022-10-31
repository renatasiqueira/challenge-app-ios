import Foundation

struct Avatar: Decodable {
    var login: String
    var id: Int
    var avatarUrl: URL

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
      }
}
