import UIKit
import Alamofire


class MainViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    private var verticalStackView = UIStackView()
    private var horizontalSearchStackView = UIStackView()
    private var imageView = UIImageView()
    private var imageContainerView = UIView()
    private var emojisListButton = UIButton()
    private var randomEmojisButton = UIButton()
    private var avatarListButton = UIButton()
    private var appleReposButton = UIButton()
    private var searchButton = UIButton()
    private var searchBar = UISearchBar()
    
    private var urlEmojiImage : String
  
    // --------- HOW TO START ---------
    // 1 - CREATE THE VIEWS
    // 2 - ADDVIEWS TO SUPERVIEW
    // 3 - SET THE CONSTRAINTS
    // --------------------------------
    
    // 1 - CREATE VIEWS
    
    init() {
        emojisListButton = .init(type: .system)
        randomEmojisButton = .init(type: .system)
        avatarListButton = .init(type: .system)
        appleReposButton = .init(type: .system)
        searchButton = .init(type: .system)
        searchBar = .init(frame: .zero)
        imageView = .init(frame: .zero)
        imageContainerView = .init(frame: .zero)
        urlEmojiImage = .init()
        horizontalSearchStackView = .init(arrangedSubviews: [searchBar, searchButton])
        verticalStackView = .init(arrangedSubviews: [imageContainerView, randomEmojisButton, emojisListButton, horizontalSearchStackView, avatarListButton, appleReposButton])
        
        //horizontalSearchStackView.addArrangedSubview(searchBar)
        //horizontalSearchStackView.addArrangedSubview(searchButton)
        
       // imageContainerView.addSubview(imageView)
        
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        addViewToSuperView()
        setUpConstraints()
        
    }

    
//1 - Setup the Views
    private func setUpViews() {
        view.backgroundColor = .systemBlue
        view.tintColor = .lightGray
        
        //imageView.backgroundColor = .orange
        //imageContainerView.backgroundColor = .white
                
        verticalStackView.axis = .vertical
        //verticalStackView.spacing = 20
        
        horizontalSearchStackView.axis = .horizontal
        //horizontalSearchStackView.spacing = 20
        
        emojisListButton.setTitle("Emojis List", for: .normal)
        //emojisListButton.configuration = .filled()
        //emojisListButton.configuration?.baseBackgroundColor = .lightGray
        
        randomEmojisButton.setTitle("Random Emojis", for: .normal)
        //randomEmojisButton.configuration = .filled()
        //randomEmojisButton.configuration?.baseBackgroundColor = .lightGray
        
        avatarListButton.setTitle("Avatars List", for: .normal)
        //avatarListButton.configuration = .filled()
        //avatarListButton.configuration?.baseBackgroundColor = .lightGray
        
        appleReposButton.setTitle("Apple Repos", for: .normal)
        //appleReposButton.configuration = .filled()
        //appleReposButton.configuration?.baseBackgroundColor = .lightGray
        
        searchButton.setTitle("Search", for: .normal)
        //searchButton.configuration = .filled()
        //cd ..searchButton.configuration?.baseBackgroundColor = .lightGray
        
        self.navigationController?.navigationBar.tintColor = .white
        
        emojisListButton.addTarget(self, action: #selector(didTapEmojisList), for: .touchUpInside)
        
        randomEmojisButton.addTarget(self, action: #selector(didTapRandomEmojis), for: .touchUpInside)
        
        avatarListButton.addTarget(self, action: #selector(didTapAvatarList), for: .touchUpInside)
        
        appleReposButton.addTarget(self, action: #selector(didTapAppleRepos), for: .touchUpInside)
        
        print("Begin of code")
        let url = URL(string: "https://github.githubassets.com/images/icons/emoji/unicode/1f44d.png?v8")!
        downloadImage(from: url)
        print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
        
        
    }
//2 - Add to views
    private func addViewToSuperView() {
        imageContainerView.addSubview(imageView)
        
        view.addSubview(verticalStackView)

    }
//3 - Set the constraints
    private func setUpConstraints() {
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30)
        ])
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor), // constant: 70),
            imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: -70),
            imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
           
        
        ])
        verticalStackView.spacing = 20;
        horizontalSearchStackView.spacing = 20;
        
    }
    
    @objc func didTapEmojisList(_ sender: UIButton) {
        coordinator?.eventOccurred(with: .emojisListButton)
    }
    
    @objc func didTapRandomEmojis(_ sender:UIButton) {
        //coordinator?.eventOccurred(with: .randomEmojisButton)
        let randomNumber = Int.random(in: 0 ... (emojiStorage?.emojis.count ?? 0))
                
        guard let emoji = emojiStorage?.emojis.item(at: randomNumber) else { return }

        urlEmojiImage = emoji.url
        
        let url = URL(string: urlEmojiImage)!
        downloadImage(from: url)
        }
    
    @objc func didTapAvatarList(_ sender:UIButton) {
        coordinator?.eventOccurred(with: .avatarListButton)
    }
    
    @objc func didTapAppleRepos(_ sender:UIButton) {
        coordinator?.eventOccurred(with: .appleReposButton)
    }
    
    //Create a method with a completion handler to get the image data from your url
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    //Create a method to download the image (start the task)
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
}

