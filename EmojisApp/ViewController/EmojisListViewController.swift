import Foundation
import UIKit

class EmojisListViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    var emojiService: EmojiService?
    var emojisList: [Emoji] = []

    var viewModel: EmojisViewModel?

//    lazy var collectionView: UICollectionView = {
//        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
//        return collectionV
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        addViewToSuperView()
        setUpConstraints()

        collectionView.backgroundColor = .none
    }

    private func setUpViews() {
        setUpCollectionView()
    }

    private func addViewToSuperView() {
        view.addSubview(collectionView)
    }

    private func setUpConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setUpCollectionView() {
        view.backgroundColor = .appColor(name: .primary)
        view.tintColor = .appColor(name: .secondary)
        title = "Emojis List"
        // 1 - Collection's Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4

        // 2 - Collection's Constructor
        collectionView = .init(frame: .zero, collectionViewLayout: layout)

        // 3 - Registering the Cells
        collectionView.register(EmojiCollectionViewCell.self,
                                forCellWithReuseIdentifier: EmojiCollectionViewCell.reuseCellIdentifier )

        // 4 - Delegate & DataSource
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emojiService?.getEmojisList({ (result: Result<[Emoji], Error>) in
            switch result {
            case .success(let success):
                self.emojisList = success
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                }
            case .failure(let failure):
                print("Error: \(failure)")
            }
        })

    }
}

// Collection's Data Source
extension EmojisListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let countEmojis = emojisList.count
        return countEmojis
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: EmojiCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        let url = emojisList[indexPath.row].emojiUrl

        cell.setUpCell(url: url)

        return cell
    }
}

class MockedDataSource: NSObject, UICollectionViewDataSource {
    var mockedEmojis: MockedEmojiStorage = .init()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return mockedEmojis.emojis.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: EmojiCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.setUpCell(url: mockedEmojis.emojis[indexPath.row].emojiUrl)

        return cell
    }

}

// - Collection's Delegate Flow Layout
extension EmojisListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {return .zero}
        let widthPerItem = collectionView.frame.width / 3 - layout.minimumInteritemSpacing

        return CGSize(width: widthPerItem - 8, height: widthPerItem)
    }

}
