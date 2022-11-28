import UIKit
import RxSwift

class AvatarsListViewController: BaseGenericViewController<AvatarListView> {

    weak var delegate: SendBackDelegate?

    var coordinator: Coordinator?

    var avatarList: [Avatar] = []

    var viewModel: AvatarViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Avatar List"

        genericView.collectionView.dataSource = self
        genericView.collectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel?.getAvatar()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] avatars in
                guard let self = self else { return }
                self.avatarList = avatars
            }, onFailure: { error in
                print("Error to get Avatars: \(error)")
            }, onDisposed: {
                print("Avatars is on!")
            })
            .disposed(by: disposeBag)
    }

    deinit {
        self.delegate?.navigateToMainPage()
    }
}

extension AvatarsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return avatarList.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        let url = avatarList[indexPath.row].avatarUrl

        cell.setUpCell(url: url)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let alert = genericView.createDeleteAlert { [weak self] in
            guard let self = self else { return }
            let avatar = self.avatarList[indexPath.row]
            self.viewModel?.avatarService?.deleteAvatar(avatarToDelete: avatar)
        }

        self.present(alert, animated: true, completion: nil)
    }

}

extension AvatarsListViewController: UICollectionViewDelegateFlowLayout {
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
