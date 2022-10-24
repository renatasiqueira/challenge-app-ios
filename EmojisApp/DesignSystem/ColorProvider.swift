import Foundation
import UIKit

enum ColorProvider: String {
    case primary
    case onPrimary
    case suface
    case secondary
    case safeBar
}

extension UIColor {
    static func appColor(name: ColorProvider) -> UIColor?{
        return UIColor(named: name.rawValue)
    }
}
