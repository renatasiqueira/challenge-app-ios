import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var mainPageCoordinator: MainPageCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        NetworkManager.initialize()

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navVC = UINavigationController()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()

        let application: Application = .init()

        mainPageCoordinator = MainPageCoordinator(navigationController: navVC, application: application)

        mainPageCoordinator?.start()
        window?.makeKeyAndVisible()

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
