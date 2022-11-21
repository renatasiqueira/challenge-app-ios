import Foundation
import CoreData

class LiveAvatarService: AvatarService {

    private var networkManager: NetworkManager = .init()
    private var persistence: PersistenceAvatar {
        return .init(persistentContainer: persistentContainer)
    }
    private var persistentContainer: NSPersistentContainer
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    var avatars: [Avatar] = []

    func fetchAvatarList(_ resultHandler: @escaping ([Avatar]) -> Void) {

        persistence.fetchAvatarData { (result: [Avatar]) in
            if result.count != 0 {
                resultHandler(result)
            }
        }
    }

    func getAvatar(searchText: String, _ resultHandler: @escaping (Result<Avatar, Error>) -> Void) {
        persistence.checkAvatarList(login: searchText) { (result: Result<[Avatar], Error>) in
            switch result {
            case .success(let success):
                if !success.isEmpty {
                    guard let avatar = success.first else { return }
                    resultHandler(.success(avatar))
                } else {
                    self.networkManager.executeNetworkCall(AvatarAPI.getAvatars(searchText)
                    ) { (result: Result<Avatar, Error>) in
                        switch result {
                        case .success(let success):
                            self.persistence.saveAvatar(currentAvatar: success)
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

    func deleteAvatar(avatarToDelete: Avatar) {
        persistence.delete(avatarObject: avatarToDelete)
    }
}
