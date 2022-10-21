import UIKit

class AvatarsListViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    var avatarService: LiveAvatarStorage?
    
    var avatarList: [Avatar]  = []
    
    lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        addViewsToSuperview()
        setUpConstraints()
        
        collectionView.backgroundColor = .none
    }
    
    private func setUpViews(){
        setUpCollectionView()
    }
    
    private func addViewsToSuperview(){
        view.addSubview(collectionView)
    }
    
    private func setUpConstraints(){
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
        view.backgroundColor = .appColor(name: .primary)
        view.tintColor = .appColor(name: .secondary)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(EmojiCollectionViewCells.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avatarService?.fetchAvatarList({ (result: [Avatar]) in
            self.avatarList = result
        })
        
    }
    
}

extension AvatarsListViewController: AvatarStorageDelegate {
    func avatarListUpdated() {
        collectionView.reloadData()
    }
}

extension AvatarsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return avatarList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EmojiCollectionViewCells else {
            return UICollectionViewCell()
        }
        
        let url = avatarList[indexPath.row].avatarUrl
        
        cell.setUpCell(url: url)
        
        return cell
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
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 3 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: widthPerItem)
    }
}
