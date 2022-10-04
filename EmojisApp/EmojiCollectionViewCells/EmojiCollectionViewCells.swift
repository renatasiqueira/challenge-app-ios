import UIKit


class EmojiCollectionViewCells: UICollectionViewCell {
    /*var color: UIColor = .white {
     didSet {
     backgroundColor = color
     }
     */
    
    private var emojiImageView: UIImageView
    var dataTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        emojiImageView = .init(frame: .zero)
        //emojiImageView.contentMode = .scaleAspectFit
        //emojiImageView.clipsToBounds = true
        //sel.emojiImageView = emoji
        super.init(frame: .zero)
        self.contentView.addSubview(emojiImageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(url: URL) {
        downloadImage(from: url)
    }
    
    func setupConstraints(){
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

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        dataTask?.cancel()
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        dataTask?.resume()
    }
    
    func downloadImage(from url: URL){
        getData(from: url) { [weak self] data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    self?.emojiImageView.image = nil
                    self?.dataTask = nil
                }
                return
            }
            DispatchQueue.main.async() { () in
                self?.emojiImageView.image = nil
                self?.dataTask = nil
                guard let data = data, error == nil else { return }
                self?.emojiImageView.image = UIImage(data: data)
            }
        }
    }
}

