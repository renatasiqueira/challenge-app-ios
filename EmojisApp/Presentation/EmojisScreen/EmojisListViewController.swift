import Foundation
import UIKit
//
import RxSwift

class EmojisListViewController: BaseGenericViewController<EmojisView> {

    var coordinator: Coordinator?
    var emojisList: [Emoji] = []
    var viewModel: EmojisViewModel?

    weak var delegate: SendBackDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Emojis List"
        genericView.collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getEmojis()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] emojisList in
                guard let self = self else { return }
                self.emojisList = emojisList
                self.genericView.collectionView.reloadData()
            }, onFailure: { error in
                print("[Get emojis] - \(error)")
            }, onDisposed: {
                print("[Get emojis] - Disposed")
            })
            .disposed(by: disposeBag)
    }
    deinit {
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

//        cell.setUpCell(url: url)

        guard let viewModel = viewModel else { return UICollectionViewCell() }
        viewModel.imageAtUrl(url: url)
            .asOptional()
            .subscribe(cell.imageView.rx.image)
            .disposed(by: cell.reusableDisposeBag)

        return cell
    }
}
