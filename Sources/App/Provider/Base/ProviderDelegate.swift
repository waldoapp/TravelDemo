import Foundation

internal protocol ProviderDelegate: NSObjectProtocol {

    // MARK: Instance Properties

    var appInBackground: Bool { get }

    var appInForeground: Bool { get }
}
