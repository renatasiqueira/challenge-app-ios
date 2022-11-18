import UIKit

class AvatarsListViewController: BaseGenericViewController<AvatarListView> {

    public weak var delegate: SendBackDelegate?

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
        self.viewModel?.avatarList.bind(listener: { [weak self] avatars in
            guard let self = self,
                  let avatars = avatars else {return}
            self.avatarList = avatars
            DispatchQueue.main.async {
                self.genericView.collectionView.reloadData()
            }

        })

        viewModel?.getAvatar()
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
        let avatar = self.avatarList[indexPath.row]
        let message: String = "Do you want to delete \(avatar.login)?"

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
