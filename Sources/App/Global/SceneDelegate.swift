import UIKit

public class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: Public Instance Properties

    public var coordinator: MainCoordinator?
    public var window: UIWindow?

    // MARK: Public Instance Methods

    public func scene(_ scene: UIScene,
                      willConnectTo session: UISceneSession,
                      options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene,
              let window = scene.windows.first,
              let nc = window.rootViewController as? UINavigationController
        else { return }

        coordinator = MainCoordinator(nc)

        coordinator?.start()
    }

    public func sceneDidBecomeActive(_ scene: UIScene) {
    }

    public func sceneDidDisconnect(_ scene: UIScene) {
    }

    public func sceneDidEnterBackground(_ scene: UIScene) {
    }

    public func sceneWillEnterForeground(_ scene: UIScene) {
    }

    public func sceneWillResignActive(_ scene: UIScene) {
    }
}
