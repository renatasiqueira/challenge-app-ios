import Foundation
import UIKit.UIImage

public class AppleReposViewModel {
    private var itemsPerPage: Int = 10
    private var pageNumber: Int = 1

    var appleReposService: AppleReposService?

    var appleReposList: Box<[AppleRepos]?> = Box([])
    var isEnd: Box<Bool> = Box(false)

    init(appleReposService: AppleReposService) {
        self.appleReposService = appleReposService
    }

    func getRepos() {
        self.pageNumber += 1
        self.appleReposService?.getRepos(itemsPerPage: itemsPerPage,
                                         pageNumber: pageNumber, { (result: Result<[AppleRepos], Error>) in
            switch result {
            case .success(let success):
                self.appleReposList.value?.append(contentsOf: success)
                if success.count < self.itemsPerPage {
                    self.isEnd.value = true
                }
            case .failure(let failure):
                print("Failure: \(failure)")
            }
        })
    }
}
