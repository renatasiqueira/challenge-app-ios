import UIKit


class AvatarCollectionViewCell: UICollectionViewCell {
      
    private var avatarImageView: UIImageView
    var dataTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        avatarImageView = .init(frame: .zero)
        super.init(frame: .zero)
        self.contentView.addSubview(avatarImageView)
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(url: URL) {
        downloadImage(from: url)
    }
    
    func setupConstraints(){
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        dataTask?.cancel()
        
        avatarImageView.image = nil
        
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
                    self?.avatarImageView.image = nil
                    self?.dataTask = nil
                }
                return
            }
            DispatchQueue.main.async() { () in
                self?.avatarImageView.image = nil
                self?.dataTask = nil
                guard let data = data, error == nil else { return }
                self?.avatarImageView.image = UIImage(data: data)
            }
        }
    }
}

