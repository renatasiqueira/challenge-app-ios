import UIKit

class AppleReposViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?

    private var tableView: UITableView

    var appleRepos: [AppleRepos]  = []

    var viewModel: AppleReposViewModel?

    private var itemsPerPage: Int = 10
    private var pageNumber: Int = 1

    var mockedAppleReposDataSource: MockAppleReposDataSource?

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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setUpTableView() {
        title = "Apple Repos"

        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(AppleReposTableViewCell.self,
                           forCellReuseIdentifier: AppleReposTableViewCell.reuseCellIdentifier)

        tableView.dataSource = self
        tableView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel?.appleReposList.bind(listener: {[weak self] newAppleRepos in
            guard let newAppleRepos = newAppleRepos else {return}
            self?.appleRepos = newAppleRepos

            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }

        }

        )}
}

// MARK: - UITableViewDataSource
extension AppleReposViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appleRepos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: AppleReposTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let reposApple = appleRepos[indexPath.row]

        cell.textLabel?.text = reposApple.fullName

        return cell

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.y
        print("offset: \(offset)")

        let heightVisibleScroll = scrollView.frame.size.height
        print("heightVisibleScroll: \(heightVisibleScroll)")

        let heightTable = scrollView.contentSize.height
        print("heightTable: \(heightTable)")
        if offset > 0 && (offset + heightVisibleScroll)
            >
            (heightTable-heightVisibleScroll*0.2) && addedToView && !isEnd {

        }
    }

}


