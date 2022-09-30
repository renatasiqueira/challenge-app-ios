import Foundation
import UIKit

/*
 Steps to create a Collection View:
 
 1 - Create the Collection's layout
 2 - Initialize the Collection
 3 - Register the Cells
 4 - Set the Data Source and the Delegate
 */



class EmojisListViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    var collectionView: UICollectionView!
    var colors: [UIColor] = [.blue, .green, .red, .yellow, .black]
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        addViewToSuperView()
        setUpConstraints()
        //view.backgroundColor = .systemPink
        title = "Emojis List"

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
    
}

        // Collection's Data Source
    extension EmojisListViewController: UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return mockedEmojis.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EmojiCollectionViewCells else {
                return UICollectionViewCell()
            }
            //cell.color = colors[indexPath.row]
            cell.backgroundColor = .black
            
            let imageView: UIImageView = .init(frame: .zero)
            let urlString: String = mockedEmojis[indexPath.row].url
            let url = URL(string: urlString)!
            
            downloadImage(from: url, imageView: imageView)
            
            cell.contentView.addSubview(imageView)
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
                    
            NSLayoutConstraint.activate([imageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                                         imageView.centerYAnchor.constraint(equalTo: cell.centerYAnchor)])
    
        
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
        
    //Create a method with a completion handler to get the image data from your url
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    //Create a method to download the image (start the task)
        func downloadImage(from url: URL, imageView: UIImageView) {
    
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
            }
        }
        }
}
