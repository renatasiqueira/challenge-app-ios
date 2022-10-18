import Foundation
import CoreData



class LiveAvatarStorage: AvatarService {
    
    private var networkManager: NetworkManager = .init()
    private var avatarPersistence: PersistenceAvatar = .init()
    
    weak var delegate: AvatarStorageDelegate?
    
    var avatars: [Avatar] = []
    
    
    init(){
        
    }
    
    func getAvatar(_ resultHandler: @escaping (Result<[Avatar], Error>) -> Void) {
        
        
    }
    
    func fetchAvatarList(_ resultHandler: @escaping ([Avatar]) -> Void){
        
        avatarPersistence.fetchAvatarData() { (result: [NSManagedObject]) in
            if !result.isEmpty {
                let avatars = result.map({ item in
                    return item.ToAvatar()
                })
                
                resultHandler(avatars)
                
            }
        }
    }
    
    func getAvatar(searchText: String,_ resultHandler: @escaping (Result<Avatar, Error>) -> Void){
        avatarPersistence.checkAvatarList(searchText: searchText){(result: Result<[NSManagedObject], Error>) in
            switch result {
            case .success(let success):
                if !success.isEmpty {
                    guard let avatar = success.first else { return }
                    resultHandler(.success(avatar.ToAvatar()))
                } else {
                    self.networkManager.executeNetworkCall(AvatarAPI.getAvatars(searchText)) { (result: Result<Avatar, Error>) in
                        switch result {
                        case .success(let success):
                            self.avatarPersistence.persist(currentAvatar: success)
                            resultHandler(.success(success))
                        case .failure(let failure):
                            print("Error: \(failure)")
                        }
                    }
                }
            case .failure(let failure):
                print("Error: \(failure)")
            }
            
            
        }
    }
}

protocol AvatarPresenter: AvatarStorageDelegate {
    var avatarService: AvatarService? { get set }
}

//protocol AvatarStorage {
//    var delegate: AvatarStorageDelegate? { get set }
//    var avatars: [Avatar] { get set }
//}
