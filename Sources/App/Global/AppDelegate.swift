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
}

//@UIApplicationMain
//public class AppDelegate: UIResponder {
//
//    // MARK: Public Instance Properties
//
//    public lazy var director: Director = .init(appDelegate: self)
//
//    public var window: UIWindow?
//
//    // MARK: Private Instance Methods
//
//    private func state(of application: UIApplication) -> String {
//        return Formatter.format(application.applicationState)
//    }
//}
//
// MARK: - UIApplicationDelegate
//
//extension AppDelegate: UIApplicationDelegate {
//
//    // MARK: Public Instance Methods
//
//    public func application(_ application: UIApplication,
//                            didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        logInfo("[\(state(of: application))] Application did finish launching, options: \(launchOptions ?? [:])")
//
//        return director.didFinishLaunching(launchOptions)
//    }
//
//    public func application(_ application: UIApplication,
//                            open url: URL,
//                            options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
//        logInfo("[\(state(of: application))] Application open URL: \(url), options: \(options)")
//
//        return director.openURL(url,
//                                options: options)
//    }
//
//    public func application(_ application: UIApplication,
//                            willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
//        let result = director.willFinishLaunching(launchOptions)
//
//        logInfo("[\(state(of: application))] Application will finish launching, options: \(launchOptions ?? [:])")
//
//        return result
//    }
//
//    public func applicationDidBecomeActive(_ application: UIApplication) {
//        logInfo("[\(state(of: application))] Application did become active")
//
//        director.didBecomeActive()
//    }
//
//    public func applicationDidEnterBackground(_ application: UIApplication) {
//        logInfo("[\(state(of: application))] Application did enter background")
//
//        director.didEnterBackground()
//    }
//
//    public func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
//        logWarn("[\(state(of: application))] Application did receive memory warning")
//
//        director.didReceiveMemoryWarning()
//    }
//
//    public func applicationWillEnterForeground(_ application: UIApplication) {
//        logInfo("[\(state(of: application))] Application will enter foreground")
//
//        director.willEnterForeground()
//    }
//
//    public func applicationWillResignActive(_ application: UIApplication) {
//        logInfo("[\(state(of: application))] Application will resign active")
//
//        director.willResignActive()
//    }
//
//    public func applicationWillTerminate(_ application: UIApplication) {
//        logInfo("[\(state(of: application))] Application will terminate")
//
//        director.willTerminate()
//    }
//}
