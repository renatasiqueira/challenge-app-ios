import Foundation

struct Avatar: Codable, CustomStringConvertible {
    var login: String
    var id: Int
    var avatarUrl: URL
    
    var description: String {
        "\(login): \(id) :\(avatarUrl)"
    }
}
