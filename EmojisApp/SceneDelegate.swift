import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        NetworkManager.initialize()

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navVC = UINavigationController()

        let coordinator = MainCoordinator(emojiService: LiveEmojiStorage(),
                                          avatarService: LiveAvatarStorage(),
                                          appleReposService: LiveAppleReposStorage())
        coordinator.navigationController = navVC

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()

        coordinator.start()

    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }

}
