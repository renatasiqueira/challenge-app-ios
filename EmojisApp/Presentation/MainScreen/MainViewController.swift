import UIKit
import CoreData
import Alamofire

class MainViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    var emojiService: EmojiService?
    var avatarService: LiveAvatarStorage = .init()

    var networkManager: NetworkManager = .init()

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
    private var emojiImage = UIImageView()

    private var urlEmojiImage: String

    var viewModel: MainViewModel?
    var application: Application?

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
        verticalStackView = .init(arrangedSubviews: [imageContainerView,
                                                     randomEmojisButton,
                                                     emojisListButton,
                                                     horizontalSearchStackView,
                                                     avatarListButton,
                                                     appleReposButton])

        super.init(nibName: nil, bundle: nil)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.emojiImageUrl.bind(listener: { url in
            guard let url = url else {return}
            self.imageView.stopLoading()
            self.imageView.downloadedImage(from: url)

        })

        setUpViews()
        addViewToSuperView()
        setUpConstraints()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setUpViews() {
        view.backgroundColor = .appColor(name: .suface)
        view.tintColor = .appColor(name: .onPrimary)

        verticalStackView.axis = .vertical

        horizontalSearchStackView.axis = .horizontal

        emojisListButton.setTitle("Emojis List", for: .normal)

        randomEmojisButton.setTitle("Random Emojis", for: .normal)

        avatarListButton.setTitle("Avatars List", for: .normal)

        appleReposButton.setTitle("Apple Repos", for: .normal)

        searchButton.setTitle("Search", for: .normal)

        let buttonArray = [randomEmojisButton, emojisListButton, searchButton, avatarListButton, appleReposButton]
        buttonArray.forEach {
            $0.configuration = .filled()
        }

        self.navigationController?.navigationBar.tintColor = .appColor(name: .onPrimary)

        emojisListButton.addTarget(self, action: #selector(didTapEmojisList), for: .touchUpInside)

        randomEmojisButton.addTarget(self, action: #selector(getRandomEmojis), for: .touchUpInside)

        avatarListButton.addTarget(self, action: #selector(didTapAvatarList), for: .touchUpInside)

        appleReposButton.addTarget(self, action: #selector(didTapAppleRepos), for: .touchUpInside)

        searchButton.addTarget(self, action: #selector(getSearchAvatar), for: .touchUpInside)

        getRandomEmojis()

        emojiImage.showLoading()

    }
    // 2 - Add to views
    private func addViewToSuperView() {
        imageContainerView.addSubview(imageView)

        view.addSubview(verticalStackView)

    }
    // 3 - Set the constraints
    private func setUpConstraints() {

        searchButton.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor), // constant: 70),
            imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: -70),
            imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45)
        ])
        verticalStackView.spacing = 20
        horizontalSearchStackView.spacing = 20

    }

    @objc func didTapEmojisList(_ sender: UIButton) {
        coordinator?.eventOccurred(with: .emojisListButton)
    }

    @objc func didTapAvatarList(_ sender: UIButton) {
        coordinator?.eventOccurred(with: .avatarListButton)
    }

    @objc func didTapAppleRepos(_ sender: UIButton) {
        coordinator?.eventOccurred(with: .appleReposButton)
    }

    @objc func getRandomEmojis() {
        viewModel?.getRandom()
    }

    @objc func getSearchAvatar() {
        viewModel?.searchQuery.value = searchBar.text
    }

}
