import UIKit

class ColorCell: UICollectionViewCell {
    var color: UIColor = .white {
        didSet {
            backgroundColor = color
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // NOTE: - Don't forget to clear your cell before reusing it!
        self.backgroundColor = .clear
    }
}
