import Foundation
import UIKit

extension UICollectionViewCell: ReusableView {}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {

        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseCellIdentifier, for: indexPath) as? T
        else { fatalError("Unable to Dequeue Reusable Collection View Cell")
        }

        return cell
    }
}
