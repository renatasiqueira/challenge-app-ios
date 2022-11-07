import UIKit
import Alamofire

class EmojiCollectionViewCell: UICollectionViewCell {

     private let emojiImageView: UIImageView
     var dataTask: URLSessionDataTask?

    override init(frame: CGRect) {
        emojiImageView = .init(frame: .zero)
        super.init(frame: .zero)
        self.contentView.addSubview(emojiImageView)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpCell(url: URL) {
        // downloadImage(from: url)
        dataTask = emojiImageView.createDownloadDataTask(from: url)
        dataTask?.resume()
    }

    func setupConstraints() {
        emojiImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            emojiImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            emojiImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            emojiImageView.topAnchor.constraint(equalTo: self.topAnchor),
            emojiImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    override func prepareForReuse() {

        super.prepareForReuse()
        dataTask?.cancel()

        emojiImageView.image = nil

    }

}
