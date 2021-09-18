import UIKit

@main
public class AppDelegate: UIResponder, UIApplicationDelegate {
    public func application(_ application: UIApplication,
                            configurationForConnecting connectingSceneSession: UISceneSession,
                            options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration",
                             sessionRole: connectingSceneSession.role)
    }

    public func application(_ application: UIApplication,
                            didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    public func application(_ application: UIApplication,
                            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        true
    }

    public func application(_ application: UIApplication,
                            willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        TravelSpotError.configureMessages()

        return true
    }
}
