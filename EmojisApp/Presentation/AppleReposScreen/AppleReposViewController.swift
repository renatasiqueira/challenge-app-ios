import UIKit

class AppleReposViewController: BaseGenericViewController<AppleReposView> {

    public weak var delegate: SendBackDelegate?

    var appleRepos: [AppleRepos]  = []
    var viewModel: AppleReposViewModel?

    private var addedToView: Bool = false
    private var isEnd: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple Repos"

        genericView.tableView.dataSource = self
        genericView.tableView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel?.appleReposList.bind(listener: { [weak self] newAppleRepos in
            guard let newAppleRepos = newAppleRepos else {return}
            self?.appleRepos = newAppleRepos

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.addedToView = true
                if self.genericView.tableView.contentSize.height < self.genericView.tableView.frame.size.height {
                    self.viewModel?.getRepos()
                }
                self.genericView.tableView.reloadData()
            }
        }
        )
        viewModel?.isEnd.bind(listener: { [weak self] ended in
            guard let self = self else { return }
            self.isEnd = ended
        })
    }

}

// MARK: - UITableViewDataSource
extension AppleReposViewController: UITableViewDataSource, UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.y

        let heightVisibleScroll = scrollView.frame.size.height

        let heightTable = scrollView.contentSize.height

        if offset > 0
            && (offset + heightVisibleScroll) >
            (heightTable - (heightVisibleScroll*0.2))
            && addedToView
            && !isEnd {
            addedToView = false
            viewModel?.getRepos()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: ReposNameTableViewCell = tableView.dequeueReusableCell(for: indexPath)

        cell.setUpCells(textField: appleRepos[indexPath.row].fullName)

        return cell

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return appleRepos.count
    }
}
