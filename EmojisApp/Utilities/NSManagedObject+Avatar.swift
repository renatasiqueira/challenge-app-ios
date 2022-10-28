import Foundation

import UIKit
import CoreData

extension NSManagedObject {
    func toAvatar() -> Avatar?{

        guard let login = self.value(forKey: "login") as? String else {return nil}
        guard let id = self.value(forKey: "id") as? Int else {return nil}
        guard let avatarUrl = self.value(forKey: "avatarUrl") as? String else {return nil}
        guard let url = URL(string: avatarUrl) else {return nil}

        return Avatar(
            login: login,
            id: id,
            avatarUrl: url
        )
    }
}
