import Foundation
import UIKit


class EmojisListViewController: UIViewController, Coordinating, EmojiPresenter {
    
    var coordinator: Coordinator?
    var emojiStorage: EmojiStorage?
    lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        return v
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        addViewToSuperView()
        setUpConstraints()
        
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
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setUpCollectionView() {
        view.backgroundColor = .systemPink
        title = "Emojis List"
        // 1 - Collection's Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        
        // 2 - Collection's Constructor
        collectionView = .init(frame: .zero, collectionViewLayout: layout)
        
        // 3 - Registering the Cells
        collectionView.register(EmojiCollectionViewCells.self, forCellWithReuseIdentifier: "cell")
        
        // 4 - Delegate & DataSource
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Emojis: \(String(describing: emojiStorage?.emojis.count))")
    }
    
}
extension EmojisListViewController: EmojiStorageDelegate {
    func emojiListUpdated() {
        collectionView.reloadData()
    }
}
        // Collection's Data Source
    extension EmojisListViewController: UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            let mockedEmojis = emojiStorage?.emojis.count ?? 0
            return mockedEmojis
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EmojiCollectionViewCells else {
                return UICollectionViewCell()
            }
           
            let url = (emojiStorage?.emojis[indexPath.row].emojiUrl)!
            
            cell.setupCell(url: url)
            
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
        
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    let widthPerItem = collectionView.frame.width / 3 - layout.minimumInteritemSpacing
        
    return CGSize(width: widthPerItem - 8, height: widthPerItem)
    }
   
}
