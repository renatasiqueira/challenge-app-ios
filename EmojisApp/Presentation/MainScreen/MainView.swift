import UIKit
//
import RxCocoa
import RxSwift

class MainView: BaseGenericView {

    private var verticalStackView = UIStackView()
    private var horizontalSearchStackView = UIStackView()
    var imageView = UIImageView()
    private var imageContainerView = UIView()
    var emojisListButton = UIButton()
    var randomEmojisButton = UIButton()
    var avatarListButton = UIButton()
    var appleReposButton = UIButton()
    var searchButton = UIButton()
    var searchBar = UISearchBar()

    // 1 - CREATE VIEWS

    override init(frame: CGRect) {
        emojisListButton = .init(type: .system)
        randomEmojisButton = .init(type: .system)
        avatarListButton = .init(type: .system)
        appleReposButton = .init(type: .system)
        searchButton = .init(type: .system)
        searchBar = .init(frame: .zero)
        imageView = .init(frame: .zero)
        imageContainerView = .init(frame: .zero)
        horizontalSearchStackView = .init(arrangedSubviews: [searchBar, searchButton])
        verticalStackView = .init(arrangedSubviews: [imageContainerView,
                                                     randomEmojisButton,
                                                     emojisListButton,
                                                     horizontalSearchStackView,
                                                     avatarListButton,
                                                     appleReposButton])

        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func createViews() {
        setUpViews()
        addViewToSuperView()
        setUpConstraints()
    }

    private func setUpViews() {
        backgroundColor = .appColor(name: .suface)
        tintColor = .appColor(name: .onPrimary)

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
    }

    // 2 - Add to views
    private func addViewToSuperView() {
        imageContainerView.addSubview(imageView)

        addSubview(verticalStackView)

    }
    // 3 - Set the constraints
    private func setUpConstraints() {

        searchButton.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            verticalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor), // constant: 70),
            imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: -70),
            imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45)
        ])
        verticalStackView.spacing = 20
        horizontalSearchStackView.spacing = 20

        imageView.contentMode = .scaleAspectFit
    }

}
