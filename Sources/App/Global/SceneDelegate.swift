import UIKit

public class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: Public Instance Properties

    public var mainCoordinator: MainCoordinator?
    public var window: UIWindow?

    // MARK: Public Instance Methods

    public func scene(_ scene: UIScene,
                      continue userActivity: NSUserActivity) {
        guard let deepLink = DeepLink(userActivity)
        else { return }

        mainCoordinator?.showDeepLink(deepLink)
    }

    public func scene(_ scene: UIScene,
                      willConnectTo session: UISceneSession,
                      options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene,
              let window = scene.windows.first,
              let nc = window.rootViewController as? UINavigationController
        else { return }

        let mc = MainCoordinator(nc)

        mc.start()

        mainCoordinator = mc
    }

    public func sceneDidBecomeActive(_ scene: UIScene) {
    }

    public func sceneDidDisconnect(_ scene: UIScene) {
        mainCoordinator = nil
    }

    public func sceneDidEnterBackground(_ scene: UIScene) {
    }

    public func sceneWillEnterForeground(_ scene: UIScene) {
    }

    public func sceneWillResignActive(_ scene: UIScene) {
    }
}
