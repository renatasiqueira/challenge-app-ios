import UIKit
import CoreData


class AppleReposViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    var appleReposService: AppleReposService?
    
    
    private var tableView: UITableView
    
    private var reposList: [AppleRepos]  = []
    
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
        
        view.backgroundColor = .appColor(name: .safeBar)
        
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
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setUpTableView() {
        title = "Apple Repos"
        
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(AppleReposTableViewCell.self, forCellReuseIdentifier: AppleReposTableViewCell.reuseCellIdentifier)
                
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
extension AppleReposViewController: UITableViewDataSource, UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        let offset = scrollView.contentOffset.y
        print("offset: \(offset)")
        
        let heightVisibleScroll = scrollView.frame.size.height
        print("heightVisibleScroll: \(heightVisibleScroll)")
        
        let heightTable = scrollView.contentSize.height
        print("heightTable: \(heightTable)")
        
        if (offset > 0 && (offset + heightVisibleScroll) > (heightTable-heightVisibleScroll*0.2) && addedToView && !isEnd) {
            
            addedToView = false
            self.pageNumber += 1
            self.appleReposService?.getRepos(itemsPerPage: itemsPerPage, pageNumber: pageNumber){ (result: Result<[AppleRepos], Error>) in
                switch result{
                case .success(let success):
                    self.reposList.append(contentsOf: success)
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadData()
                    }
                    
                    if success.count < self.itemsPerPage {
                        self.isEnd = true
                    }
                    
                case .failure(let failure):
                    print("Failure: \(failure)")
                }
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addedToView = true
        return reposList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: AppleReposTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let fullName = reposList[indexPath.row].fullName
        
        cell.textLabel?.text = fullName
        
        return cell
        
    }
    
}
