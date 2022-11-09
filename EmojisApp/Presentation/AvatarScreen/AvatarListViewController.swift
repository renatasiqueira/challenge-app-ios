import UIKit

class AvatarsListViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    // var avatarService: LiveAvatarStorage?

    var avatarList: [Avatar]  = []

    var viewModel: AvatarViewModel?

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

        setUpViews()
        addViewsToSuperview()
        setUpConstraints()

        collectionView.backgroundColor = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.avatarList.bind(listener: { [weak self] avatars in
            guard let self = self,
                  let avatars = avatars else {return}
            self.avatarList = avatars
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }

        })

        viewModel?.getAvatar()
    }

    private func setUpViews() {
        setUpCollectionView()
    }

    private func addViewsToSuperview() {
        view.addSubview(collectionView)
    }

    private func setUpConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

    }

    private func setUpCollectionView() {
        title = "Avatars List"

        collectionView.register(CellsCollectionView.self,
                                forCellWithReuseIdentifier: CellsCollectionView.reuseCellIdentifier)

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}

extension AvatarsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return avatarList.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: CellsCollectionView = collectionView.dequeueReusableCell(for: indexPath)

        let url = avatarList[indexPath.row].avatarUrl

        cell.setUpCell(url: url)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let avatar = self.avatarList[indexPath.row]
        let message: String = "Do you want to delete \(avatar.login)?"
        let alert = UIAlertController(title: "Deleting \(avatar.login)...", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_: UIAlertAction) in
            self.viewModel?.deleteAvatar(avatar: avatar, at: indexPath.row)

        }))

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
