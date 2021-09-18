import UIKit

public class ProviderHub {

    // MARK: Public Instance Properties

//    public let logging: LoggingProvider

    // MARK: Public Instance Methods

    public func didBecomeActive() {
        providers.forEach { $0.didBecomeActive() }
    }

    public func didEnterBackground() {
        providers.forEach { $0.didEnterBackground() }
    }

    public func didFinishLaunching(_ options: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        for provider in providers {
            guard provider.didFinishLaunching(options)
                else { return false }
        }

        return true
    }

    public func didReceiveMemoryWarning() {
        providers.forEach { $0.didReceiveMemoryWarning() }
    }

    public func willEnterForeground() {
        providers.forEach { $0.willEnterForeground() }
    }

    public func willFinishLaunching(_ options: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        for provider in providers {
            guard provider.willFinishLaunching(options)
                else { return false }
        }

        return true
    }

    public func willResignActive() {
        providers.forEach { $0.willResignActive() }
    }

    public func willTerminate() {
        providers.forEach { $0.willTerminate() }
    }

    // MARK: Internal Initializers

    internal init() {
//        //
//        // Logging provider requires special handling:
//        //
//        let tmpLogging = LoggingProvider()
//
//        LoggingProvider.shared = tmpLogging
//
//        self.logging = tmpLogging

        self.providers = []
    }

    // MARK: Private Instance Properties

    private let providers: [Provider]
}
