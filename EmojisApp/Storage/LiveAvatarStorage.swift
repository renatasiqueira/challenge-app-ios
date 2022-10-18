import Foundation
import CoreData



class LiveAvatarStorage: AvatarStorage {
    
    private var networkManager: NetworkManager = .init()
    private var avatarPersistence: PersistenceAvatar = .init()
    
    weak var delegate: AvatarStorageDelegate?
    
    var avatars: [Avatar] = []

    
    init(){
        loadAvatars()
    }
    
    func loadAvatars() {
        
    }
}

protocol AvatarPresenter: AvatarStorageDelegate {
    var avatarStorage: AvatarStorage? { get set }
}

protocol AvatarStorage {
    var delegate: AvatarStorageDelegate? { get set }
    var avatars: [Avatar] { get set }
}
