import Foundation
import CoreData

class LiveAppleReposStorage: AppleReposService {

    var appleRepos: [AppleRepos] = []

    private var networkManager: NetworkManager = .init()

    weak var delegate: ReposStorageDelegate?

    func getRepos(itemsPerPage: Int, pageNumber: Int, _ resultHandler:
                  @escaping (Result<[AppleRepos], Error>) -> Void) {
        networkManager.executeNetworkCall(ReposAPI.getRepos(perPage: itemsPerPage,
                                                            page: pageNumber)) {(result: Result<[AppleRepos], Error>) in
            switch result {
            case .success(let success):
                resultHandler(.success(success))
            case .failure(let failure):
                resultHandler(.failure(failure))
                print("Error: \(failure)")
            }
        }
    }
}
