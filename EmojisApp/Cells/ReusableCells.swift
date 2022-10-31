import Foundation

protocol ReusableView {
    static var reuseCellIdentifier: String { get }
}

extension ReusableView {
    static var reuseCellIdentifier: String {

        return String(describing: self)
    }
}
