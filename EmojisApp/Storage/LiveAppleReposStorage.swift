import Foundation
import CoreData


class LiveAppleReposStorage: AppleReposService {
    
    
    var appleRepos: [AppleRepos] = []
    
    private var networkManager: NetworkManager = .init()
    private var appleReposPersistence: PersistenceAppleRepos = .init()
    
    weak var delegate: ReposStorageDelegate?
        
    
    func getRepos(itemsPerPage: Int, pageNumber: Int, _ resultHandler: @escaping (Result<[AppleRepos], Error>) -> Void) {
        
        
    }
}
