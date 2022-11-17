import UIKit
import CoreData
import Alamofire

class MainViewController: BaseGenericViewController<MainView> {

    weak var delegate: MainViewControllerDelegate?

    var viewModel: MainPageViewModel?

    var networkManager: NetworkManager = .init()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        genericView.imageView.showLoading()

        viewModel?.emojiImageUrl.bind(listener: { url in
            guard let url = url else {return}
            let dataTask = self.genericView.imageView.createDownloadDataTask(from: url)
            dataTask.resume()

            self.genericView.imageView.stopLoading()

        })
        getRandomEmojis()

        self.navigationController?.navigationBar.tintColor = .appColor(name: .primary)

        genericView.emojisListButton.addTarget(self, action: #selector(didTapEmojisList), for: .touchUpInside)
        genericView.avatarListButton.addTarget(self, action: #selector(didTapAvatarList), for: .touchUpInside)
        genericView.appleReposButton.addTarget(self, action: #selector(didTapAppleRepos), for: .touchUpInside)
        genericView.randomEmojisButton.addTarget(self, action: #selector(getRandomEmojis), for: .touchUpInside)
        genericView.searchButton.addTarget(self, action: #selector(getSearchAvatar), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @objc func didTapEmojisList(_ sender: UIButton) {

        self.delegate?.navigateToEmojiList()
    }

    @objc func didTapAvatarList(_ sender: UIButton) {

        self.delegate?.navigateToAvatarList()
    }

    @objc func didTapAppleRepos(_ sender: UIButton) {

        self.delegate?.navigateToAppleRepos()
    }

    @objc func getRandomEmojis() {
        viewModel?.getRandom()
    }

    @objc func getSearchAvatar() {

        viewModel?.searchQuery.value = genericView.searchBar.text
        genericView.searchBar.text = ""
    }

}
