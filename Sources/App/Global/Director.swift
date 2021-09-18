//import UIKit
//
//public class Director {
//
//    // MARK: Public Instance Properties
//
//    public unowned let appDelegate: AppDelegate
//    public unowned let application: UIApplication
//
//    public private(set) lazy var configuration: Configuration = .init()
//    public private(set) lazy var preferences: Preferences = .init(delegate: self)
//    public private(set) lazy var providers: ProviderHub = .init()
//
//    public var rootViewController: UIViewController? {
//        appDelegate.window?.rootViewController
//    }
//
//    // MARK: Public Instance Methods
//
//    public func didBecomeActive() {
//        if wasInBackground {
//            preferences.synchronizeCloud()
//
//            wasInBackground = false
//        }
//
//        providers.didBecomeActive()
//    }
//
//    public func didEnterBackground() {
//        providers.didEnterBackground()
//    }
//
//    public func didFinishLaunching(_ options: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        preferences.launchTime = now()
//        preferences.synchronizeCloud()
//
//        return providers.didFinishLaunching(options)
//    }
//
//    public func didReceiveMemoryWarning() {
//        providers.didReceiveMemoryWarning()
//    }
//
//    public func openURL(_ url: URL,
//                        options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
//        guard
//            url.isFileURL,
//            let browser = rootViewController as? MainDocumentBrowserViewController
//            else { return false }
//
//        browser.revealDocument(at: url,
//                               importIfNeeded: true) { docURL, error in
//                                if let error = error {
//                                    print("Unable to reveal document at URL \(url), error: \(error)")
//                                    return
//                                }
//
//                                guard
//                                    let docURL = docURL
//                                    else { return }
//
//                                browser.openDocument(at: docURL)
//        }
//
//        return true
//    }
//
//    public func willEnterForeground() {
//        wasInBackground = true
//
//        providers.willEnterForeground()
//    }
//
//    public func willFinishLaunching(_ options: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        configure()
//
//        UIApplication.LaunchOptionsKeyFinishLaunching(options)
//    }
//
//    public func willResignActive () {
//        providers.willResignActive()
//    }
//
//    public func willTerminate() {
//        providers.willTerminate()
//    }
//
//    // MARK: Public Initializers
//
//    public init(appDelegate: AppDelegate) {
//        self.appDelegate = appDelegate
//        self.application = .shared
//        self.wasInBackground = false
//    }
//
//    // MARK: Private Instance Properties
//
//    private var wasInBackground: Bool
//
//    // MARK: Private Instance Methods
//
//    private func configure() {
//        guard
//            !preferences.exampleProfileCopyDone
//            else { return }
//
//        preferences.exampleProfileCopyDone = true
//
//        preferences.synchronizeLocal()
//    }
//}
//
// MARK: - PreferencesDelegate
//
//extension Director: PreferencesDelegate {
//    var appBundleID: String? {
//        configuration.appBundleID
//    }
//}
