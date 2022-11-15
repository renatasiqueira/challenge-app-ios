import Foundation
import UIKit
import CoreData

extension NSManagedObject {
    func toEmojis() -> Emoji? {

        guard let nameItem = self.value(forKey: "name") as? String else { return nil }
        guard let urlString = self.value(forKey: "url") as? String else { return nil }
        guard let urlItem = URL(string: urlString) else { return nil }
        return Emoji(name: nameItem, emojiUrl: urlItem)

    }
}
