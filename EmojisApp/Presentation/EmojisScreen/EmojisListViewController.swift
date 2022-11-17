import Foundation
import UIKit

class EmojisListViewController: BaseGenericViewController<EmojisView> {

    var coordinator: Coordinator?
    var emojisList: [Emoji] = []
    var viewModel: EmojisViewModel?

    public weak var delegate: SendBackDelegate?

    private var collectionView: UICollectionView

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4

        collectionView = .init(frame: .zero, collectionViewLayout: layout)

        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Emojis List"
        genericView.collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.emojisList.bind(listener: { [weak self] arrayEmojis in
            guard let arrayEmojis = arrayEmojis else {return}
            self?.emojisList = arrayEmojis
            DispatchQueue.main.async { [weak self] in
                self?.genericView.collectionView.reloadData()
            }
        })
        viewModel?.getEmojis()
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.delegate?.navigateToMainPage()
    }
}

extension EmojisListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let countEmojis = emojisList.count
        return countEmojis
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        let url = emojisList[indexPath.row].emojiUrl

        cell.setUpCell(url: url)

        return cell
    }
}
