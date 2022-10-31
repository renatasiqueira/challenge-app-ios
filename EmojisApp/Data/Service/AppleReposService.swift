import UIKit

protocol AppleReposService {
    func getRepos(itemsPerPage: Int, pageNumber: Int, _ resultHandler: @escaping (Result<[AppleRepos], Error>) -> Void)
}
