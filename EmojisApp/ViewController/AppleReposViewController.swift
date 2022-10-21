import UIKit
import CoreData


class AppleReposViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    var appleReposService: AppleReposService?
    
    
    private var tableView: UITableView
    
    private var reposList: [AppleRepos]  = []
    
    private var mockedAppleReposStorage: MockedAppleReposStorage = .init()
    
    private var itemsPerPage: Int = 10
    private var pageNumber: Int = 1
    
    private var addedToView: Bool = false
    private var isEnd: Bool = false
    
    
    init() {
        tableView = .init(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        addViewToSuperView()
        setUpConstraints()
        
    }
    
    private func setUpViews() {
        setUpTableView()
    }
    
    private func addViewToSuperView() {
        view.addSubview(tableView)
    }
    
    private func setUpConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setUpTableView() {
        title = "Apple Repos"
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AppleReposCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appleReposService?.getRepos(itemsPerPage: itemsPerPage, pageNumber: pageNumber){ (result: Result<[AppleRepos], Error>) in
            
            switch result {
            case .success(let success):
                self.reposList = success
                DispatchQueue.main.async {
                    [weak self] in
                    self?.tableView.reloadData()
                }
            case .failure(let failure):
                print("Error getting appleRepos data \(failure)")
            }
        }
        
    }
    
}

// MARK: - UITableViewDataSource


